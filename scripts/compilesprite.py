#!/usr/bin/python3

import sys
import argparse
import ntpath
import itertools

from pathlib import Path
from PIL import Image
from array import *

CLIP_TOP=0
CLIP_BOTTOM=184 - 16
SCANLINE=352

parser = argparse.ArgumentParser(description='Compile indexed color PNG sprite to Acorn ARM assembler.')
parser.add_argument('-i', '--infile', nargs='+', type=argparse.FileType('rb'),default=sys.stdin)
parser.add_argument('-o', '--outfile', nargs='+', type=argparse.FileType('wt'),default=sys.stdout)
parser.add_argument('-sw', '--spritewidth', type=int,default=-1)
parser.add_argument('-sh', '--spriteheight', type=int,default=-1)
parser.add_argument('-mi', '--maskindex', type=int,default=0)
parser.add_argument('-afx', '--allowflipx', type=bool,default=False)
parser.add_argument('-afy', '--allowflipy', type=bool,default=False)

args = parser.parse_args()

filenames = [args.infile, args.outfile]

for infile, outfile in zip(args.infile, args.outfile):
    filename = Path(ntpath.basename(infile.name)).stem

    image = Image.open(infile)
    image_name = filename
    image_width,image_height = image.size

    sprite_width = args.spritewidth
    sprite_height = args.spriteheight
    mask_index = args.maskindex
    allow_flip_x = args.allowflipx
    allow_flip_y = args.allowflipy

    if sprite_width == -1:
        sprite_width = image_width

    if sprite_height == -1:
        sprite_height = image_height

    sprite_frames = int(image_width / sprite_width) * int(image_height / sprite_height)

    palette_name = filename + "_palette"
    palette_type,palette_data = image.palette.getdata()

    f_out = outfile

    image_pixels = image.load()

    print("\ncompilesprite: '"+infile.name+"' => '"+outfile.name+"'")
    print("\tImage size   : "+f'{image_width}'+"x"+f'{image_height}')
    print("\tSprite size  : "+f'{sprite_width}'+"x"+f'{sprite_height}'+f' * {sprite_frames} frames')
    print("\tMask index   : "+f'{mask_index}')
    print("\tAllow flip X : "+f'{allow_flip_x}')
    print("\tAllow flip Y : "+f'{allow_flip_y}')
    print('')

    label_name = image_name.replace("-","_")

    f_out.write('\ndraw_'+label_name+'_sprite:\n')

    f_out.write('\tSTMFD SP!, {R0-R2,R4,R9-R12}\n')

    if (allow_flip_y == True):
        f_out.write('\tTST R3,#1 << 30\n')
        f_out.write('\tBNE draw_'+label_name+'_sprite_flip_y\n')

    f_out.write('\tMOV R9,#'+f'{CLIP_BOTTOM}\n')
    f_out.write('\tMOV R10,#1\n')
    f_out.write('\tMOV R12,#'+f'{SCANLINE}\n')
    f_out.write('\tCMP R2,#'+f'{CLIP_BOTTOM}\n')
    f_out.write('\tBGE draw_'+label_name+'_sprite_exit\n')
    f_out.write('\tCMP R2,#'+f'{0 - sprite_height}\n')
    f_out.write('\tBLE draw_'+label_name+'_sprite_exit\n')
    f_out.write('\tCMP R1,#'+f'{-16}\n')
    f_out.write('\tBLT draw_'+label_name+'_sprite_exit\n')
    f_out.write('\tCMP R1,#'+f'{SCANLINE - 16}\n')
    f_out.write('\tBGE draw_'+label_name+'_sprite_exit\n')
    f_out.write('\tCMP R0,#0\n')
    f_out.write('\tMOVLT R0,#0\n')
    f_out.write('\tCMP R0,#'+f'{sprite_frames}\n')
    f_out.write('\tMOVGE R0,#0\n')
    f_out.write('\tMOV R0,R0,LSL #2\n')
    f_out.write('\tADD R11,R11,R1\n')
    f_out.write('\tMOV R1,#'+f'{SCANLINE}\n')
    f_out.write('\tCMP R2,#0\n')
    f_out.write('\tMLAGT R11,R1,R2,R11\n')

    if (allow_flip_y == True):
        f_out.write('\tB draw_'+label_name+'_sprite_skip_flip_y\n')

        f_out.write('draw_'+label_name+'_sprite_flip_y:\n')
        f_out.write('\tADD R2,R2,#'+f'{sprite_height}\n')
        f_out.write('\tMOV R9,#'+f'{CLIP_TOP-1}\n')
        f_out.write('\tMOV R10,#-1\n')
        f_out.write('\tMVN R12,#'+f'{SCANLINE-1}\n')
        f_out.write('\tCMP R2,#'+f'{CLIP_BOTTOM + sprite_height}\n')
        f_out.write('\tBGE draw_'+label_name+'_sprite_exit\n')
        f_out.write('\tCMP R2,#'+f'{0}\n')
        f_out.write('\tBLE draw_'+label_name+'_sprite_exit\n')
        f_out.write('\tCMP R1,#'+f'{-16}\n')
        f_out.write('\tBLT draw_'+label_name+'_sprite_exit\n')
        f_out.write('\tCMP R1,#'+f'{SCANLINE - 16}\n')
        f_out.write('\tBGE draw_'+label_name+'_sprite_exit\n')
        f_out.write('\tCMP R0,#0\n')
        f_out.write('\tMOVLT R0,#0\n')
        f_out.write('\tCMP R0,#'+f'{sprite_frames}\n')
        f_out.write('\tMOVGE R0,#0\n')
        f_out.write('\tMOV R0,R0,LSL #2\n')
        f_out.write('\tADD R11,R11,R1\n')
        f_out.write('\tMOV R1,#'+f'{SCANLINE}\n')
        f_out.write('\tCMP R2,#'+f'{CLIP_BOTTOM-1}\n')
        f_out.write('\tMOVGE R4,#'+f'{CLIP_BOTTOM-1}\n')
        f_out.write('\tMOVLT R4,R2\n')
        f_out.write('\tMLA R11,R1,R4,R11\n')

        f_out.write('draw_'+label_name+'_sprite_skip_flip_y:\n')

    f_out.write('\tADR R1,'+label_name+'_sprites\n')
    f_out.write('\tLDR PC,[R1,R0]\n')
    f_out.write('\ndraw_'+label_name+'_sprite_exit:\n')
    f_out.write('\tLDMFD SP!, {R0-R2,R4,R9-R12}\n')
    f_out.write('\tMOV PC, R14\n')

    f_out.write('\n'+label_name+'_sprites:\n')
    
    for frame in range(0,sprite_frames):
        f_out.write('\t.4byte\t\t'+label_name+f'_sprite_{frame}\n')

    iy = 0
    tile = 0

    while iy < image_height:
        ix = 0
        while ix < image_width:
            frame = {}

            for y in range(0,sprite_height):
                for colour in range(0,256):
                    frame[y,colour] = []

            f_out.write('\n'+label_name+f'_sprite_{tile}_scanlines:\n')

            y = 0
            while y < sprite_height:
                f_out.write('\t.4byte\t\t'+label_name+f'_sprite_{tile}_scanline_{y}\n')

                x = 0
                while x < sprite_width:
                    colour = image_pixels[ix + x, iy + y]
                    if (colour != mask_index):
                        frame[y,colour].append(x)
                    x += 1
                y += 1

            f_out.write('\n'+label_name+f'_sprite_{tile}:\n')

            if (allow_flip_y == True):
                f_out.write('\tTST R3,#1 << 30\n')
                f_out.write('\tBNE '+label_name+f'_sprite_{tile}_flip_y\n')

            f_out.write('\tCMP R2,#0\n')
            f_out.write('\tBGE '+label_name+f'_sprite_{tile}_scanline_0\n')
            f_out.write('\tMOV R0,#0\n')
            f_out.write('\tSUB R0,R0,R2\n')
            f_out.write('\tMOV R0,R0,LSL #2\n')

            if (allow_flip_y == True):
                f_out.write('\tB '+label_name+f'_sprite_{tile}_skip_flip_y\n')

                f_out.write(label_name+f'_sprite_{tile}_flip_y:\n')
                f_out.write('\tCMP R2,#'+f'{CLIP_BOTTOM}\n')
                f_out.write('\tBLT '+label_name+f'_sprite_{tile}_scanline_0\n')
                f_out.write('\tMOV R0,#'+f'{CLIP_BOTTOM}\n')
                f_out.write('\tSUB R0,R2,R0\n')
                f_out.write('\tMOV R0,R0,LSL #2\n')
                f_out.write(label_name+f'_sprite_{tile}_skip_flip_y:\n')

            f_out.write('\tADR R1,'+label_name+f'_sprite_{tile}_scanlines\n')
            f_out.write('\tLDR PC,[R1,R0]\n')

            for i in range(0,sprite_height):
                jj = -1
                f_out.write('\n'+label_name+f'_sprite_{tile}_scanline_{i}:\n')

                if (allow_flip_x == True):
                    f_out.write('\tTST R3,#1 << 31\n')
                    f_out.write('\tBNE '+label_name+f'_sprite_{tile}_scanline_{i}_flip_x\n')

                for j in range(0,256):
                    if len(frame[i,j]) > 0:
                        if jj != j:
                            f_out.write('\tMOV R0,#'+f'0x{j:02x}\n')
                            f_out.write('\tORR R0,R0,R3\n')
                            f_out.write('\tAND R0,R0,R3,LSR #8\n')
                            ii = i
                        
                        for x in frame[i,j]:
                            f_out.write('\tSTRB R0,[R11,#'+f'{x:d}]\n')
                        
                f_out.write('\tADD R11,R11,R12\n')
                f_out.write('\tADD R2,R2,R10\n')
                f_out.write('\tCMP R2,R9\n')
                f_out.write('\tBEQ '+label_name+f'_sprite_{tile}_exit\n')

                if (allow_flip_x == True):
                    f_out.write('\tB '+label_name+f'_sprite_{tile}_scanline_{i}_skip_flip_x\n')
                    f_out.write(label_name+f'_sprite_{tile}_scanline_{i}_flip_x:\n')

                    for j in range(0,256):
                        if len(frame[i,j]) > 0:
                            if jj != j:
                                f_out.write('\tMOV R0,#'+f'0x{j:02x}\n')
                                f_out.write('\tORR R0,R0,R3\n')
                                f_out.write('\tAND R0,R0,R3,LSR #8\n')
                                ii = i
                            
                            for x in frame[i,j]:
                                f_out.write('\tSTRB R0,[R11,#'+f'{sprite_width - x:d}]\n')
                            
                    f_out.write('\tADD R11,R11,R12\n')
                    f_out.write('\tADD R2,R2,R10\n')
                    f_out.write('\tCMP R2,R9\n')
                    f_out.write('\tBEQ '+label_name+f'_sprite_{tile}_exit\n')

                    f_out.write(label_name+f'_sprite_{tile}_scanline_{i}_skip_flip_x:\n')

            f_out.write('\n'+label_name+f'_sprite_{tile}_exit:\n')
            f_out.write('\tLDMFD SP!, {R0-R2,R4,R9-R12}\n')
            f_out.write('\tMOV PC,R14\n')

            tile = tile + 1

            ix += sprite_width
            if ix < image_width:
                if iy <= (image_height - sprite_height):
                    f_out.write('\n')
                        
        iy += sprite_height

    f_out.write(label_name+'_end:\n\n')
    f_out.close()