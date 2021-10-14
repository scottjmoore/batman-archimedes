#!/usr/bin/python3

import sys
import argparse
import ntpath
import itertools

from pathlib import Path
from PIL import Image

parser = argparse.ArgumentParser(description='Convert indexed color PNG to assembler directives.')
parser.add_argument('-i', '--infile', nargs='+', type=argparse.FileType('rb'),default=sys.stdin)
parser.add_argument('-o', '--outfile', nargs='+', type=argparse.FileType('wt'),default=sys.stdout)
parser.add_argument('-sw', '--spritewidth', type=int,default=8)
parser.add_argument('-sh', '--spriteheight', type=int,default=8)
parser.add_argument('-ss', '--spriteshift', action="store_true")

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

    print("png2asm: '"+infile.name+"' => '"+outfile.name+"'")
    print("\tImage size : "+f'{image_width}'+"x"+f'{image_height}')
    print("\tSprite size : "+f'{sprite_width}'+"x"+f'{sprite_height}')

    label_name = image_name.replace("-","_")
    f_out.write(label_name+':\n')

    iy = 0

    while iy < image_height:
        ix = 0
        while ix < image_width:
            y = 0
            while y < sprite_height:
                x = 0
                f_out.write('\t.byte\t')
                while x < sprite_width:
                    b0 = image_pixels[ix + x + 0,iy + y]
                    b1 = image_pixels[ix + x + 1,iy + y]
                    b2 = image_pixels[ix + x + 2,iy + y]
                    b3 = image_pixels[ix + x + 3,iy + y]
                    b4 = image_pixels[ix + x + 4,iy + y]
                    b5 = image_pixels[ix + x + 5,iy + y]
                    b6 = image_pixels[ix + x + 6,iy + y]
                    b7 = image_pixels[ix + x + 7,iy + y]
                    f_out.write(f'0x{b0:02x},'+f'0x{b1:02x},'+f'0x{b2:02x},'+f'0x{b3:02x},'+f'0x{b4:02x},'+f'0x{b5:02x},'+f'0x{b6:02x},'+f'0x{b7:02x}')
                    x += 8
                    if x < sprite_width:
                        f_out.write(',')
                    else:
                        f_out.write('\n')
                y += 1
            ix += sprite_width
            if ix < image_width:
                if iy <= (image_height - sprite_height):
                    f_out.write('\n')
        iy += sprite_height

    # if args.spriteshift:

    #     print("\tSprite shift : Creating byte shifted versions")
        
    #     f_out.write(image_name+'_shift1:\n')

    #     y = 0
    #     while y < sprite_height:
    #         x = 1
    #         while x < sprite_width:
    #             b0 = image_pixels[x + 0,y]
    #             b1 = image_pixels[x + 1,y]
    #             b2 = image_pixels[x + 2,y]
    #             b3 = image_pixels[x + 3,y]
    #             b4 = image_pixels[x + 4,y]
    #             b5 = image_pixels[x + 5,y]
    #             b6 = image_pixels[x + 6,y]

    #             if (x+7 < sprite_width):
    #                 b7 = image_pixels[x + 7,y]
    #                 f_out.write('\t\t\t.byte\t'+f'0x{b0:0x},'+f'0x{b1:0x},'+f'0x{b2:0x},'+f'0x{b3:0x},'+f'0x{b4:0x},'+f'0x{b5:0x},'+f'0x{b6:0x},'+f'0x{b7:0x}\n')
    #             else:
    #                 f_out.write('\t\t\t.byte\t'+f'0x{b0:0x},'+f'0x{b1:0x},'+f'0x{b2:0x},'+f'0x{b3:0x},'+f'0x{b4:0x},'+f'0x{b5:0x},'+f'0x{b6:0x}\n')

    #             x += 8
    #         bs0 = image_pixels[0,y]
    #         f_out.write('\t\t\t.byte\t'+f'0x{bs0:0x}\n')
    #         y += 1

    #     f_out.write(image_name+'_shift2:\n')

    #     y = 0
    #     while y < sprite_height:
    #         x = 2
    #         while x < sprite_width:
    #             b0 = image_pixels[x + 0,y]
    #             b1 = image_pixels[x + 1,y]
    #             b2 = image_pixels[x + 2,y]
    #             b3 = image_pixels[x + 3,y]
    #             b4 = image_pixels[x + 4,y]
    #             b5 = image_pixels[x + 5,y]

    #             if (x+6 < sprite_width):
    #                 b6 = image_pixels[x + 6,y]
    #                 b7 = image_pixels[x + 7,y]
    #                 f_out.write('\t\t\t.byte\t'+f'0x{b0:0x},'+f'0x{b1:0x},'+f'0x{b2:0x},'+f'0x{b3:0x},'+f'0x{b4:0x},'+f'0x{b5:0x},'+f'0x{b6:0x},'+f'0x{b7:0x}\n')
    #             else:
    #                 f_out.write('\t\t\t.byte\t'+f'0x{b0:0x},'+f'0x{b1:0x},'+f'0x{b2:0x},'+f'0x{b3:0x},'+f'0x{b4:0x},'+f'0x{b5:0x}\n')

    #             x += 8
    #         bs0 = image_pixels[0,y]
    #         bs1 = image_pixels[1,y]
    #         f_out.write('\t\t\t.byte\t'+f'0x{bs0:0x},'+f'0x{bs1:0x}\n')
    #         y += 1

    #     f_out.write(image_name+'_shift3:\n')

    #     y = 0
    #     while y < sprite_height:
    #         x = 3
    #         while x < sprite_width:
    #             b0 = image_pixels[x + 0,y]
    #             b1 = image_pixels[x + 1,y]
    #             b2 = image_pixels[x + 2,y]
    #             b3 = image_pixels[x + 3,y]
    #             b4 = image_pixels[x + 4,y]

    #             if (x+5 < sprite_width):
    #                 b5 = image_pixels[x + 5,y]
    #                 b6 = image_pixels[x + 6,y]
    #                 b7 = image_pixels[x + 7,y]
    #                 f_out.write('\t\t\t.byte\t'+f'0x{b0:0x},'+f'0x{b1:0x},'+f'0x{b2:0x},'+f'0x{b3:0x},'+f'0x{b4:0x},'+f'0x{b5:0x},'+f'0x{b6:0x},'+f'0x{b7:0x}\n')
    #             else:
    #                 f_out.write('\t\t\t.byte\t'+f'0x{b0:0x},'+f'0x{b1:0x},'+f'0x{b2:0x},'+f'0x{b3:0x},'+f'0x{b4:0x}\n')

    #             x += 8
    #         bs0 = image_pixels[0,y]
    #         bs1 = image_pixels[1,y]
    #         bs2 = image_pixels[2,y]
    #         f_out.write('\t\t\t.byte\t'+f'0x{bs0:0x},'+f'0x{bs1:0x},'+f'0x{bs2:0x}\n')
    #         y += 1

    f_out.write(label_name+'_end:\n\n')

    f_out.close()