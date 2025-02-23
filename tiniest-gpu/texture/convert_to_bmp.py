from PIL import Image
import sys
from numpy import asarray

input_name = sys.argv[1] + ".jpg"
output_name = sys.argv[1] + ".bin"

im = Image.open(input_name).convert('1')

f = open(output_name, 'w')

a = asarray(im)

bit_list = []

for x in a:
    for y in x:
        if not y:
            bit_list.append(1)
        else:
            bit_list.append(0)

for i in range(0, len(bit_list), 8):
    byte_str = ''.join(str(bit) for bit in list(reversed(bit_list[i:i+8])))
    byte_val = int(byte_str, 2)
    f.write(format(byte_val, 'x'))
    f.write("\n")
