from block_expander import *

from math import floor
from copy import copy
import pygame
from pygame.locals import *
from sys import exit

wc1pal = [0,   0,   0,   4,   4,   4,   8,   8,   8,  13,  13,  13,  17,  17,  17,  21,
 21,  21,  25,  25,  25,  29,  29,  29,  33,  33,  33,  38,  38,  38,  42,  42,
 42,  46,  46,  46,  50,  50,  50,  54,  54,  54,  59,  59,  59,  63,  63,  63,
 63,  63,  63,  61,  59,  56,  59,  54,  50,  58,  50,  44,  56,  46,  39,  54,
 43,  33,  52,  39,  28,  50,  35,  24,  49,  32,  19,  43,  29,  17,  37,  25,
 15,  31,  21,  13,  25,  17,  10,  19,  13,   8,  13,   9,   5,   7,   5,   3,
 60,  60,  63,  51,  51,  62,  43,  44,  61,  35,  36,  60,  28,  29,  59,  21,
 22,  58,  13,  15,  57,   7,   9,  56,   0,   2,  55,   0,   2,  47,   0,   1,
 39,   0,   1,  31,   0,   1,  23,   0,   0,  16,   0,   0,   8,   0,   0,   0,
 60,  60,  63,  53,  52,  58,  46,  46,  53,  40,  40,  48,  34,  34,  43,  30,
 29,  38,  24,  24,  34,  20,  19,  29,  16,  15,  24,  12,  11,  21,   9,   8,
 18,   6,   5,  15,   4,   3,  13,   2,   2,  10,   0,   0,   7,   0,   0,   4,
 63,  63,  54,  63,  63,  46,  63,  63,  39,  63,  63,  31,  63,  62,  23,  63,
 61,  16,  63,  61,   8,  63,  61,   0,  63,  53,   0,  63,  46,   0,  63,  38,
  0,  63,  30,   0,  63,  22,   0,  63,  15,   0,  63,   7,   0,  63,   0,   0,
 62,   0,   0,  57,   0,   0,  53,   0,   0,  49,   0,   0,  45,   0,   0,  41,
  0,   0,  37,   0,   0,  33,   0,   0,  29,   0,   0,  25,   0,   0,  20,   0,
  0,  16,   0,   0,  12,   0,   0,   8,   0,   0,   4,   0,   0,   0,   0,   0,
 63,  63,  63,  61,  54,  63,  58,  45,  63,  55,  36,  63,  53,  27,  63,  50,
 18,  63,  47,   9,  63,  45,   0,  63,  39,   0,  55,  33,   0,  47,  28,   0,
 39,  22,   0,  31,  17,   0,  24,  11,   0,  16,   5,   0,   8,   0,   0,   0,
 63,  63,  63,  61,  55,  52,  59,  48,  42,  56,  41,  32,  54,  34,  23,  52,
 28,  15,  50,  22,   7,  48,  18,   0,  42,  15,   0,  36,  13,   0,  30,  10,
  0,  24,   8,   0,  18,   6,   0,  12,   4,   0,   6,   2,   0,   0,   0,   0,
 63,  63,  63,  63,  57,  54,  63,  51,  45,  63,  45,  36,  63,  38,  27,  63,
 32,  18,  63,  26,   9,  63,  19,   0,  55,  16,   0,  47,  14,   0,  39,  12,
  0,  31,   9,   0,  24,   7,   0,  16,   5,   0,   8,   2,   0,   0,   0,   0,
 63,  63,  63,  54,  60,  63,  45,  56,  63,  36,  53,  63,  27,  50,  63,  18,
 46,  63,   9,  43,  63,   0,  39,  63,   0,  34,  55,   0,  29,  47,   0,  24,
 39,   0,  19,  31,   0,  15,  24,   0,  10,  16,   0,   5,   8,   0,   0,   0,
 63,  63,  63,  58,  63,  50,  52,  63,  38,  47,  63,  25,  42,  63,  13,  36,
 63,   0,  32,  56,   0,  29,  50,   0,  25,  44,   0,  21,  38,   0,  18,  31,
  0,  14,  25,   0,  11,  19,   0,   7,  13,   0,   3,   6,   0,   0,   0,   0,
 63,  60,  56,  61,  53,  48,  59,  44,  41,  57,  35,  34,  56,  28,  32,  54,
 21,  32,  52,  15,  33,  50,  10,  36,  48,   5,  42,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   8,
 63,  61,   0,  56,  62,   0,  45,  61,   0,  36,  61,   0,  27,  60,   0,  18,
 59,   0,   9,  58,   0,   9,  51,   0,   8,  45,   0,   6,  38,   0,   5,  32,
  0,   4,  26,   0,   3,  19,   0,   2,  13,   0,   1,   6,   0,   0,   0,   0,
 60,  63,  58,  55,  59,  51,  50,  54,  46,  45,  50,  40,  41,  46,  35,  37,
 42,  30,  33,  38,  26,  30,  34,  22,  25,  31,  17,  20,  27,  13,  16,  24,
 10,  11,  21,   7,   7,  17,   4,   4,  14,   2,   2,  11,   1,   0,   8,   0,
 12,  22,  11,  20,  28,  12,  20,  32,  16,  24,  36,  20,  32,  48,  24,  36,
 56,  28,  44,  60,  32,  56,  63,  52,  18,  13,   0,  24,  16,   0,  32,  23,
  0,  40,  31,   2,  48,  40,   4,  52,  47,  12,  56,  53,  21,  60,  60,  32,
 63,  60,  56,  56,  52,  46,  49,  44,  37,  43,  37,  30,  36,  29,  21,  29,
 22,  14,  23,  15,   8,  16,  10,   4,  28,   4,   0,  32,   7,   0,  35,   9,
  0,  39,  13,   1,  43,  17,   1,  46,  22,   1,  50,  27,   2,  58,  53, 63]

def extract_image(block):
	dims = []
	dims.append(conv_endian(block, 0, 2))
	dims.append(conv_endian(block, 2, 2))
	dims.append(conv_endian(block, 4, 2))
	dims.append(conv_endian(block, 6, 2))
	
	if dims[0] < 0 or dims[0] > 1000 or dims[1] > 1000 or dims[2] > 1000 or dims[3] > 1000:
		return []

	line = [None]*(dims[2] + dims[3] + 1)
	image = []
	for i in range(0, dims[0] + dims[1] + 1):
		image.append(copy(line))

	o = 8
	#while o < len(block):
	while o < len(block):
		o = int(o)
		keynum = conv_endian(block, o, 2)
		
		x = conv_endian(block, o+2, 2)
		if x > 32767:
			x -= 65536
		
		y = conv_endian(block, o+4, 2)
		if y > 32767:
			y -= 65536

		length = int(floor(keynum / 2))
		
		o += 6
		if keynum % 2 == 0:
			for i in range(0, length):
				if abs(x + dims[1] + i) < len(image) and abs(y + dims[2]) < len(image[x + dims[1] + i]) and o+i < len(block):
					image[x + dims[1] + i][y + dims[2]] = block[o+i]
			o += length
				
		else:
			#deal with RLE blocks
			added = 0
			while added < length and o < len(block):
				if block[o]%2 == 0:
					for i in range(0, block[o]/2):
						if abs(x + dims[1] + i + added) < len(image) and abs(y + dims[2]) < len(image[x + dims[1] + i + added]) and o+i+1 < len(block):
							image[x + dims[1] + i + added][y + dims[2]] = block[o+1+i]
					added += block[o]/2
					o += i+2
				else:
					for i in range(0, block[o]/2):
						if abs(x + dims[1] + i + added) < len(image) and abs(y + dims[2]) < len(image[x + dims[1] + i + added]) and o+1 < len(block):
							image[x + dims[1] + i + added][y + dims[2]] = block[o+1]
					added += block[o]/2
					o += 2
					
	return image
	
def display_image(image, size_mult, bright_mult):

	if type(image) is list:
		x = len(image)
		if x == 0:
			return
		if type(image[0]) is list:
			y = len(image[0])
		else:
			y = 1
		if y == 0: 
			return
	else:
		x = 1
		
	if not pygame.display.get_init:
		pygame.init()
	
	screen2 = pygame.Surface((x, y))
	pix = pygame.PixelArray(screen2)
	
	
	for i in range(0, len(image)):
		for j in range(0, len(image[i])):
			if image[i][j] != None:
				if len(image) > 1 and len(image[i]) > 1:
					pix[i][j] = [z*bright_mult for z in wc1pal[image[i][j]*3:image[i][j]*3+3]]
				elif len(image) == 1:
					pix[i] = [z*bright_mult for z in wc1pal[image[i][j]*3:image[i][j]*3+3]]
				else:
					pix[j] = [z*bright_mult for z in wc1pal[image[i][j]*3:image[i][j]*3+3]]
	
	screen = pygame.display.set_mode((x*size_mult, y*size_mult))
	pygame.transform.smoothscale(screen2, (x*size_mult, y*size_mult), screen)
	pygame.display.update()
	
	while(1):
		if pygame.event.poll().type == pygame.KEYDOWN:
			break
	
filename = "arrow.vga"
blocks = readfile(filename)
for b in blocks[:]:
	for c in b:
		image = extract_image(c)
		display_image(image, 4, 4)