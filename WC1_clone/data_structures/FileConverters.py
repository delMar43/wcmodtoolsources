"""
make lists of all files to be unpacked
##read each file as appropriate to its type

remaining undecoded files:
commsm2.dat
communic.dat
  communication strings
  plain text

convert.pal
game.pal

fonts.fnt

wingldr.tim

wc.exe
sm2.exe
"""

import os
import BlockUnpacker
import GameImage
import Gamestate
from GameImage import size_mult
import pygame

filenames = os.listdir(os.curdir)

file_groups = {}

extension = "wld"
file_groups['savegame'] = [x.lower() for x in filenames if x.split('.')[-1].lower() == extension]

name = "briefing"
file_groups['briefing'] = [x.lower() for x in filenames if x.split('.')[0].lower() == name and x.split('.')[-1].isdigit()]

name = "camp"
file_groups['campaign'] = [x.lower() for x in filenames if x.split('.')[0].lower() == name and x.split('.')[-1].isdigit()]

name = "module"
file_groups['mission'] = [x.lower() for x in filenames if x.split('.')[0].lower() == name and x.split('.')[-1].isdigit()]

name = "pcship"
file_groups['cockpit'] = [x.lower() for x in filenames if x.split('.')[0].lower() == name]

name = "shiptype"
file_groups['fighter'] = [x.lower() for x in filenames if x.split('.')[0].lower() == name]

name = "ship"
file_groups['capship'] = [x.lower() for x in filenames if x.split('.')[0].lower() == name]

name = "midgame"
file_groups['cutscene'] = [x.lower() for x in filenames if x.split('.')[0].lower() == name]

extension = "vga"
file_groups['misc_graphic'] = [x.lower() for x in filenames if x.split('.')[-1].lower() == extension]

extension = "fnt"
file_groups['font'] = [x.lower() for x in filenames if x.split('.')[-1].lower() == extension]

extension = "tim"
file_groups['tim'] = [x.lower() for x in filenames if x.split('.')[-1].lower() == extension]

data_groups = {}

for group, files in file_groups.items():
	data_groups[group] = {}
	for f in files:
		print f
		if group != "savegame":
			data_groups[group][f] = BlockUnpacker.FileReader(f)
		else:
			data_groups[group][f] = BlockUnpacker.SaveReader(f)
		
#print "".join([chr(x) for x in data_groups["briefing"]["briefing.000"].data.blocks[4].blocks[5].bytes])





if not pygame.display.get_init:
	pygame.init()

w = 320
h = 200
screen = pygame.display.set_mode((int(w*size_mult), int(h*size_mult)))
pygame.display.update()

images = {}
image_classes = ["misc_graphic", "cockpit", "fighter", "capship", "cutscene"]
for c in image_classes:
	for key, value in data_groups[c].items():
		images[key] = []
		for i in value.data.blocks:
			images[key].append([])
			for j in i.blocks:
				test_image = GameImage.GameImage(j)
				images[key][-1].append(test_image)

saves = {}				
for key, value in data_groups["savegame"].items():
	saves[key] = []
	for i in value.data.blocks:
		saves[key].append(Gamestate.Gamestate(i))

test_image = images["recroom.vga"][0][0]
			
#test_image = GameImage.GameImage(data_groups["misc_graphic"]["briefing.vga"].data.blocks[7].blocks[3])
test_image.Draw(screen)
pygame.display.update()

while(1):
	if pygame.event.poll().type == pygame.KEYDOWN:
		break