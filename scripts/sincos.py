#!/usr/bin/python3

import math

f_out = open("./build/sincos.asm","w")

f_out.write("sin:\n")
for deg in range(0,1024):
    f_out.write(f"\t.4byte {int(math.sin(math.radians(deg * (360/1024))) * (1 << 20))}\n")

f_out.write("cos:\n")
for deg in range(0,1024):
    f_out.write(f"\t.4byte {-1 * int(math.cos(math.radians(deg * (360/1024))) * (1 << 20))}\n")

f_out.close