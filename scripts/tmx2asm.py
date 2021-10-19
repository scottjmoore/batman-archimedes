#!/usr/bin/python3

import sys
import argparse
import ntpath
import xml.etree.ElementTree as ET

from pathlib import Path

parser = argparse.ArgumentParser(description='Convert tiled tmx file to assembler directives.')
parser.add_argument('-i', '--infile', type=argparse.FileType('rb'),default=sys.stdin)
parser.add_argument('-o', '--outfile', type=argparse.FileType('wt'),default=sys.stdout)
args = parser.parse_args()

filename = Path(ntpath.basename(args.outfile.name)).stem
f_out = open(args.outfile.name, "w")

tree = ET.parse(args.infile)
root = tree.getroot()

map_width = int(root.attrib.get('width'))
map_height = int(root.attrib.get('height'))

print("tmx2asm: '"+args.infile.name+"' => '"+args.outfile.name+"'")
print("\tMap size : "+f'{map_width}'+"x"+f'{map_height}')

for child in root:
    if child.tag == "tileset":
        gid = int(child.attrib.get("firstgid"))

    if child.tag == "layer":
        layer_name = child.attrib.get("name")
        layer_width = int(child.attrib.get("width"))
        layer_height = int(child.attrib.get("height"))
        for data in child:
            if data.attrib.get("encoding") == "csv":
                f_out.write(f"{filename.replace('-','_')}_{layer_name.lower()}:\n\t.nolist\n")
                layer_data = [int(e) if e.isdigit() else e for e in data.text.replace("\n","0").split(",")]

                i = 0
                for d in layer_data:
                    if i % layer_width == 0:
                        f_out.write("\t.byte ")
                    
                    u = d - gid
                    
                    if u < 0:
                        u = 0
                    
                    if i % layer_width == (layer_width - 1):
                        f_out.write(f'0x{u:02x}\n')
                    else:
                        f_out.write(f'0x{u:02x},')
                    
                    i = i + 1

                f_out.write("\t.list\n\n")

f_out.close()
        
# for layer in root.findall("./layer/[@name='tile_map']/data/"):
#     try:
#         tile_map.append(int(tile.attrib['gid'])-1)
#     except:
#         tile_map.append(0)

# f_out = args.outfile

# for tilesets in root.findall("./tileset"):
#     f_out.write(filename+"_"+tilesets.get('name')+":\t\t\tequ $"+f'{int(tilesets.get("firstgid"))-1:04x}'+"\n")

# f_out.write("\n")

# if len(tile_map) > 0:
#     f_out.write(filename+':\n')

#     i = 0
#     y = 0

#     while (y < map_height):
#         x = 0
#         f_out.write('\t\t.byte\t$')

#         while (x < map_width):
#             f_out.write(f'{tile_map[i]:02x}')
#             if ((x % 2) == 1) & (x < (map_width - 1)):
#                     f_out.write(',$')
#             x = x + 1
#             i = i + 1

#         f_out.write('\n')
#         y = y + 1

#     f_out.write(filename+'_end:\n\n')

# f_out.close()
