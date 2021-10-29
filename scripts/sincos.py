#!/usr/bin/python3

import math

print("sin:")
for deg in range(0,256):
    print(f"\t.4byte {int(math.sin(math.radians(deg * (360/256))) * (1 << 16))}")

print("cos:")
for deg in range(0,256):
    print(f"\t.4byte {int(math.cos(math.radians(deg * (360/256))) * (1 << 16))}")