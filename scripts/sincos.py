#!/usr/bin/python3

import math

f_out = open("./build/sincos.asm","w")

f_out.write("sin:\n")
for deg in range(0,256):
    f_out.write(f"\t.4byte {int(math.sin(math.radians(deg * (360/256))) * (1 << 16))}\n")

f_out.write("cos:\n")
for deg in range(0,256):
    f_out.write(f"\t.4byte {int(math.cos(math.radians(deg * (360/256))) * (1 << 16))}\n")

f_out.close