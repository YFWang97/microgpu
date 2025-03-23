#!/usr/bin/env python3
import os
import sys
import base64
import struct
import numpy as np
from pygltflib import GLTF2

###############################################################################
# 1) Basic Accessor / Buffer Format Info
###############################################################################
COMPONENT_TYPE_FORMAT = {
    5120: ('b', 1),   # BYTE
    5121: ('B', 1),   # UNSIGNED_BYTE
    5122: ('h', 2),   # SHORT
    5123: ('H', 2),   # UNSIGNED_SHORT
    5125: ('I', 4),   # UNSIGNED_INT
    5126: ('f', 4)    # FLOAT
}

ACCESSOR_TYPE_COMPONENTS = {
    "SCALAR": 1,
    "VEC2":   2,
    "VEC3":   3,
    "VEC4":   4,
    "MAT2":   4,
    "MAT3":   9,
    "MAT4":   16
}

###############################################################################
# 2) Manual Parsing of Buffers for Positions / Indices
###############################################################################
def get_accessor_data(gltf, accessor_index, gltf_file_path):
    """
    Manually parse the raw buffer data for a given accessor index.
    Returns a NumPy array of shape (count, num_components).
    
    Handles both:
      - base64-embedded buffers ("data:..."),
      - external .bin files (e.g. "scene.bin").
    """
    accessor = gltf.accessors[accessor_index]
    buffer_view = gltf.bufferViews[accessor.bufferView]
    buf = gltf.buffers[buffer_view.buffer]

    uri = buf.uri
    if uri.startswith("data:"):
        # Base64-embedded
        _, b64_data = uri.split(",", 1)
        raw_binary = base64.b64decode(b64_data)
    else:
        # External .bin file
        gltf_dir = os.path.dirname(os.path.abspath(gltf_file_path))
        bin_path = os.path.join(gltf_dir, uri)
        with open(bin_path, "rb") as f:
            raw_binary = f.read()

    # Calculate where this accessor's data begins
    byte_offset = (buffer_view.byteOffset or 0) + (accessor.byteOffset or 0)
    stride = buffer_view.byteStride or 0

    # Determine number of components (e.g., VEC3 => 3)
    num_components = ACCESSOR_TYPE_COMPONENTS[accessor.type]

    # Determine format (e.g., FLOAT => 'f')
    component_type = accessor.componentType
    if component_type not in COMPONENT_TYPE_FORMAT:
        raise ValueError(f"Unsupported componentType {component_type}")

    fmt_char, bytes_per_comp = COMPONENT_TYPE_FORMAT[component_type]
    elem_size = num_components * bytes_per_comp
    elem_struct_fmt = "<" + (fmt_char * num_components)

    data_list = []
    read_offset = byte_offset
    for _ in range(accessor.count):
        chunk = raw_binary[read_offset : read_offset + elem_size]
        read_offset += stride if stride else elem_size
        unpacked = struct.unpack(elem_struct_fmt, chunk)
        data_list.append(unpacked)

    arr = np.array(data_list)
    return arr

###############################################################################
# 3) Quad -> Triangle Conversion (No CCW Enforcement)
###############################################################################
def convert_quads_to_triangles(indices):
    """
    Split each quad [v0, v1, v2, v3] into two triangles:
      -> [v0, v1, v2] and [v2, v3, v0].
    No winding checks; purely a direct split.
    """
    new_indices = []
    for i in range(0, len(indices), 4):
        v0 = indices[i]
        v1 = indices[i+1]
        v2 = indices[i+2]
        v3 = indices[i+3]

        # First triangle
        new_indices.extend([v0, v1, v2])
        # Second triangle
        new_indices.extend([v2, v3, v0])

    return np.array(new_indices, dtype=np.int32)

###############################################################################
# 4) Extracting Data from a Single Primitive (Positions + Indices)
###############################################################################
def extract_primitive_data(gltf, primitive, gltf_file_path, convert_quads=False):
    """
    Returns (positions, indices) for one glTF primitive, with optional quad->tri conversion.
    No CCW enforcement is performed.
    """
    # 1) Positions
    pos_accessor_idx = primitive.attributes.POSITION
    positions = get_accessor_data(gltf, pos_accessor_idx, gltf_file_path).astype(np.float32)

    # 2) Indices
    if primitive.indices is not None:
        indices = get_accessor_data(gltf, primitive.indices, gltf_file_path)
        indices = indices.ravel().astype(np.int32)
    else:
        indices = np.array([], dtype=np.int32)

    # Convert quads if requested (naively, no CCW checks)
    if convert_quads and len(indices) % 4 == 0:
        indices = convert_quads_to_triangles(indices)

    return positions, indices

###############################################################################
# 5) Extract from All Meshes/Primitives
###############################################################################
def extract_all_mesh_data(gltf, gltf_file_path, convert_quads=False):
    """
    Loop through all meshes/primitives, collecting (positions, indices).
    Returns a list of tuples: (mesh_idx, prim_idx, positions, indices).
    """
    results = []
    if not gltf.meshes:
        return results

    for mesh_idx, mesh in enumerate(gltf.meshes):
        for prim_idx, primitive in enumerate(mesh.primitives):
            pos, idx = extract_primitive_data(
                gltf, primitive, gltf_file_path, convert_quads=convert_quads
            )
            results.append((mesh_idx, prim_idx, pos, idx))
    return results

###############################################################################
# 6) Deduplicate Vertices
###############################################################################
def deduplicate_vertices(all_vertices_np, all_indices_np):
    """
    Removes exact duplicate vertices (bitwise float matches).
    Remaps 'all_indices_np' so they refer to the new unique vertex indices.
    
    Returns (unique_vertices, new_indices).
    """
    unique_map = {}         # (x, y, z) -> newIndex
    unique_vertices = []    # list of vertex coords
    new_indices = []

    # For each index in the old index list,
    # find the corresponding vertex. If it's new, add it to unique_vertices.
    for old_idx in all_indices_np:
        vx, vy, vz = all_vertices_np[old_idx]
        key = (vx, vy, vz)
        
        if key not in unique_map:
            new_idx = len(unique_vertices)
            unique_map[key] = new_idx
            unique_vertices.append([vx, vy, vz])
        else:
            new_idx = unique_map[key]

        new_indices.append(new_idx)

    unique_vertices_np = np.array(unique_vertices, dtype=np.float32)
    new_indices_np = np.array(new_indices, dtype=np.int32)

    return unique_vertices_np, new_indices_np

###############################################################################
# 7) Main Script (Combine -> Deduplicate -> Export to Files)
###############################################################################
def main():
    if len(sys.argv) < 2:
        print("Usage: python export_noccw_dedup.py path/to/model.gltf [--convert-quads]")
        sys.exit(1)

    gltf_path = sys.argv[1]
    convert_quads = ("--convert-quads" in sys.argv)

    # Load the glTF
    gltf = GLTF2().load(gltf_path)

    # Extract data
    mesh_data = extract_all_mesh_data(gltf, gltf_path, convert_quads=convert_quads)

    # Combine positions & indices from all meshes
    all_vertices = []
    all_indices = []
    current_offset = 0

    for (mesh_idx, prim_idx, positions, indices) in mesh_data:
        all_vertices.extend(positions)

        # Offset the indices for this chunk
        offset_indices = [i + current_offset for i in indices]
        all_indices.extend(offset_indices)

        current_offset += len(positions)

    all_vertices_np = np.array(all_vertices, dtype=np.float32)
    all_indices_np  = np.array(all_indices, dtype=np.int32)

    # Deduplicate vertices
    unique_vertices_np, new_indices_np = deduplicate_vertices(all_vertices_np, all_indices_np)

    # Write "vertices.txt" (x y z per line)
    with open("vertices.txt", "w", encoding="utf-8") as vfile:
        for v in unique_vertices_np:
            vfile.write(f"{v[0]} {v[1]} {v[2]}\n")

    # Write "indices.txt" (3 indices per line)
    with open("indices.txt", "w", encoding="utf-8") as ifile:
        for i in range(0, len(new_indices_np), 3):
            i0 = new_indices_np[i]
            i1 = new_indices_np[i + 1]
            i2 = new_indices_np[i + 2]
            ifile.write(f"{i0} {i1} {i2}\n")

    print("Export complete.")
    print(f"Original vertex count: {len(all_vertices_np)}")
    print(f"Deduplicated to:       {len(unique_vertices_np)}")
    print(f"Triangles:            {len(new_indices_np)//3}")
    if convert_quads:
        print("Note: Quads were split into triangles (no CCW checks).")


if __name__ == "__main__":
    main()
