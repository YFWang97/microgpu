# Overview

ASIC GPU testing app written in C run on Linux. \
To be able to run on different OS, you may need to use different UART library. \
The app will send these data, 60 bytes, each frame @11520 baud rate to the GPU
- 4 vertices world coordinate that form a quad
- 1 normalize normal
- 1 normalize light direction
- 3x4 ModelViewProjection matrix. (third row is not used)
- 1 byte render mode
  - solid shading, texture, alpha masked

The data are in the format of fixed point Q8.8 except for the 1-byte render mode. \
The code has been successfully tested with the Basys3 board, sending data at 60fps.

# How to use
1. The code rely on SDL2 library for the input and windows.
   Please install SDL2 and SDL2-dev first.
2. Change the USB device target file in C code to match with the ASIC/FPGA port (line number 330)
3. short cut keys
   - arrow key: yaw pitch
   - as: zoom
   - df: change model size
   - er: X translation
   - 012: render mode
   - 34: change texture
   - 6789: change triangle 1 color
   - uiop: change triangle 2 color
4. You can also changes the vertices coordinate, quad normal and light direction using code.  I have not write short cut keys for setting them.
