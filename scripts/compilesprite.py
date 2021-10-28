#!/usr/bin/python3

import sys
import argparse
import ntpath
import itertools

from pathlib import Path
from PIL import Image
from array import *

parser = argparse.ArgumentParser(description='Compile indexed color PNG sprite to Acorn ARM assembler.')
parser.add_argument('-i', '--infile', nargs='+', type=argparse.FileType('rb'),default=sys.stdin)
parser.add_argument('-o', '--outfile', nargs='+', type=argparse.FileType('wt'),default=sys.stdout)
parser.add_argument('-sw', '--spritewidth', type=int,default=8)
parser.add_argument('-sh', '--spriteheight', type=int,default=8)

args = parser.parse_args()

filenames = [args.infile, args.outfile]

for infile, outfile in zip(args.infile, args.outfile):
    filename = Path(ntpath.basename(infile.name)).stem

    image = Image.open(infile)
    image_name = filename
    image_width,image_height = image.size

    sprite_width = args.spritewidth
    sprite_height = args.spriteheight

    palette_name = filename + "_palette"
    palette_type,palette_data = image.palette.getdata()

    f_out = outfile

    image_pixels = image.load()

    print("\ncompilesprite: '"+infile.name+"' => '"+outfile.name+"'")
    print("\tImage size   : "+f'{image_width}'+"x"+f'{image_height}')
    print("\tSprite size  : "+f'{sprite_width}'+"x"+f'{sprite_height}')

    label_name = image_name.replace("-","_")
    f_out.write(label_name+':\n')

    iy = 0
    tile = 0

    while iy < image_height:
        ix = 0
        while ix < image_width:
            frame = {}

            for y in range(0,sprite_height):
                for colour in range(0,256):
                    frame[y,colour] = []

            f_out.write(label_name+f'_sprite_{tile}'+':\n')
            y = 0
            while y < sprite_height:
                x = 0
                while x < sprite_width:
                    colour = image_pixels[ix + x, iy + y]
                    if (colour != 159):
                        frame[y,colour].append(x)
                        # print(frame[colour,y])
                    x += 1
                y += 1

            for i in range(0,sprite_height):
                jj = -1
                for j in range(0,256):
                    if len(frame[i,j]) > 0:
                        if jj != j:
                            f_out.write('\tMOV R0,#'+f'0x{j:02x}\n')
                            ii = i
                        
                        for x in frame[i,j]:
                            f_out.write('\tSTRB R0,[R11,#'+f'{x:d}]\n')
                        
                f_out.write('\tADD R11,R11,#320\n')
            f_out.write('\tMOV PC,R14\n')

            tile = tile + 1

            ix += sprite_width
            if ix < image_width:
                if iy <= (image_height - sprite_height):
                    f_out.write('\n')
                        
        iy += sprite_height

    f_out.write(label_name+'_end:\n\n')
    f_out.close()