import math
from decimal import Decimal
for i in range(91):
    fp_sin = math.sin(i * math.pi / 180)
    fx_sin = int(round(fp_sin * 16384))
    fp_cos = math.cos(i * math.pi / 180)
    fx_cos = int(round(fp_cos * 16384))
    print("sin_arr", "[", i, "] = 16'b", bin(fx_sin)[2:].zfill(16), ";\t", "cos_arr", "[", i, "] = 16'b", bin(fx_cos)[2:].zfill(16), ";\t", sep='')

