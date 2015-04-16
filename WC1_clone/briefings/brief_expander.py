from block_expander import *
from copy import copy

#mission 0 is the funerals
#mission 1-3 are unknown

class briefscreen:
	def __init__(self, raw = [], dataraw = [], branch = "", text = "", phon = "", script = "", character = 0, fontcolor = 0, background = 0, otherval = 0):
		self.raw = raw
		self.dataraw = dataraw
		self.branch = branch
		self.text = text
		self.phon = phon
		self.script = script
		self.character = character
		self.fontcolor = fontcolor
		self.background = background
		self.otherval = otherval
		#self.otherbyte2 = otherbyte2
		
def readbrief(filename):
	blocks = readfile(filename)
	
	briefings = []
	for m in range(0, len(blocks)):
		mission = blocks[m]

		briefings.append([])
		for s in range (0, len(mission), 2):
			data = mission[s]
			scene = mission[s+1]
			
			briefings[-1].append([])
			
			if type(scene) is list:
				str = "".join([chr(x) for x in scene])
			else:
				continue

			breaks = str.split("\x00")
				
			#dataords = "".join([chr(x) for x in data])
			datascreens = []
			dataraws = []
			for x in range(0, len(data), 13):
				datascreens.append(data[x:x+13])
			#split datastr by 13s, and break out individual data chunks
			#add back to writing function as well
				
			for b in range(3, len(breaks), 4):
				datascreen = datascreens[(b-3)/4]
				newscreen = briefscreen(str, datascreen, breaks[b-2], breaks[b-1], breaks[b-0], breaks[b+1], datascreen[0], datascreen[1], datascreen[2], datascreen[3]+ datascreen[4]*256)
				briefings[-1][-1].append(newscreen)
					
	return briefings
	
def writebrief(filename, briefings):
	blocks = []
	for m in range(0, len(briefings)):
		mission = briefings[m]
	
		blocks.append([])
		for s in range(0, len(mission)):
			scene = mission[s]
			str = ""
			datastr = ""
			
			#if (s % 2 == 1):
			offset = 1
			str += "\0"
			
			for screen in scene:
				str += screen.branch + "\0"
				str += screen.text + "\0"
				str += screen.phon + "\0"
				str += screen.script + "\0"
				datastr += chr(screen.character)
				datastr += chr(screen.fontcolor)
				datastr += chr(screen.background)
				datastr += chr(screen.otherval%256)
				datastr += chr(int(screen.otherval/256))
				#compute pointers
				datastr += chr(offset%256)
				datastr += chr(offset/256)
				offset += len(screen.branch) + 1
				
				datastr += chr(offset%256)
				datastr += chr(offset/256)
				offset += len(screen.text) + 1
				
				datastr += chr(offset%256)
				datastr += chr(offset/256)
				offset += len(screen.phon) + 1
				
				datastr += chr(offset%256)
				datastr += chr(offset/256)
				offset += len(screen.script) + 1
				
				#
			
			datastr += chr(254)
			if len(scene) > 0:
				datastr += datastr[-13:-1]
			else:
				datastr += "".join([chr(x) for x in screen.dataraw[1:]])
			#	print [ord(x) for x in datastr]
			#else:
			#	if len(scene) > 0:
			#		str += scene[0].raw
			
			blocks[-1].append([ord(x) for x in datastr])
			blocks[-1].append([ord(x) for x in str])
			
	writefile(filename, blocks)
	return blocks

filename = "briefing.000"
blocks = readfile(filename)
briefings = readbrief(filename)

newblocks = writebrief(filename + ".tst", briefings)

#check to see what changed
for b in range(0, len(blocks)):
	for s in range(0, len(blocks[b])):
		if (blocks[b][s]) != (newblocks[b][s]):
			print b, s
			
