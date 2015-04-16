from brief_expander import *
from graphic_expander import *
from game_structures import *
import os

#implement other branches
#implement multiple conditionals
"""
#quantify?
2(X): Branch if mission didn't go well?  Damage above a certain threshhold?
3(X): Branch if mission went well?  Damage below a certain threshhold?

#quantify promotion
10: Branch if no meeting with Halcyon after debriefing (promotion, transfer)

#must be extracted from CAMP file
13: Branch if receiving Pewter Planet
14: Branch if receiving Bronze/Silver/Gold Star
15: Branch if receiving Golden Sun

#quantify promition
16: Branch if not promoted

#must be extracted from CAMP file
19: Branch if not transferring squadrons
20: Branch if not transferring to Hornet
21: Branch if not transferring to Scimitar
22: Branch if not transferring to Raptor
23: Branch if not transferring to Rapier
24: Branch if transfer to worse ship
25: Branch if transfer to better ship

#Halcyon victory?
35: Branch if mission went well (quantifiable?)
36: Branch if mission went poorly (quantifiable?)"""

def HandleBranch(condition, args):
	retval = 0
	con = ord(condition)
	print "con: " + `con`
	print "args: " + `[x for x in args]`
	
	#unconditional branch
	if con == 1:
		retval = 1
	#branch if pilot dead
	elif con == 4 and characters[int(args[0]) + 1].diedin != -1:
		retval = 1
	#branch if pilot alive
	elif con == 5 and characters[int(args[0]) + 1].diedin == -1:
		retval = 1
	elif con == 6 and missions[curr_mission].playerkills == 0:
		retval = 1
	elif con == 7 and missions[curr_mission].playerkills > 0:
		retval = 1
	#not technically correct; original engine checks a specific pilot's kills, not just "wingman", may possibly support multiple wingmen in a single mission that way
	elif con == 8 and missions[curr_mission].wingmankills == 0:
		retval = 1
	elif con == 9 and missions[curr_mission].wingmankills > 0:
		retval = 1
	elif con == 11 and missions[curr_mission].objsuccess[int(args[0])] == 0:
		retval = 1
	elif con == 12 and missions[curr_mission].objsuccess[int(args[0])] > 0:
		retval = 1
	elif con == 17 and missions[curr_mission].ejection == 0:
		retval = 1
	elif con == 18 and missions[curr_mission].ejection == 1 and missions[curr_mission].total_ejections == 1:
		retval = 1
	elif con == 26 and missions[curr_mission].ejection == 1 and missions[curr_mission].total_ejections > 1:
		retval = 1
	elif con == 27 and missions[curr_mission].objsighted[int(args[0])] > 0:
		retval = 1
	elif con == 28 and missions[curr_mission].objsighted[int(args[0])] == 0:
		retval = 1
	elif con == 29 and characters[int(args[0]) + 1].diedin != curr_mission:
		retval = 1
	elif con == 30 and characters[int(args[0]) + 1].diedin == curr_mission:
		retval = 1
	elif con >= 31 and con <= 34 and int(args[0]) < len(aces):
		if con == 31 and aces[int(args[0])].diedin != -1:
			retval = 1
		elif con == 32 and aces[int(args[0])].diedin == -1 or aces[int(args[0])].diedin == curr_mission:
			retval = 1
		elif con == 33 and aces[int(args[0])].diedin == -1:
			retval = 1
		elif con == 34 and aces[int(args[0])].diedin != -1 and aces[int(args[0])].diedin != curr_mission:
			retval = 1
		

	return retval

"""
Variables:
$A: MEDAL TO BE AWARDED (from CAMP file)
$D: DATE
$E: PREVIOUS DATE (FOR MEDAL CEREMONY)
$S: SYSTEM
$T: TIME OF NEXT MISSION
"""
	
def InsertVars(string):
	switch = words[0][1]
	if switch == 'C':
		retval = Bluehair.callsign
	elif switch == 'K':
		retval = `missions[curr_mission].playerkills`
	elif switch == 'L':
		retval = `missions[curr_mission].wingmankills`
	elif switch == 'N':
		retval = Bluehair.name
	elif switch == 'P':
		retval = Bluehair.name
	elif switch == 'R':
		retval = ranks[Bluehair.rank]
	else:
		retval = "UNIMPLEMENTED VARIABLE"

	return retval
	
#offset of 97
mouth_codes = [2, 1, 6, 6, 3, 10, 6, 9, 2, 6, 6, 9, 1, 6, 4, 1, 8, 6, 6, 6, 5, 6, 8, 6, 6, 6]

#create window of correct size (320x200, with some multiple)
x = 320
y = 200
size_mult = 4
bright_mult = 4

pygame.init()
os.environ['SDL_VIDEO_WINDOW_POS'] = str(0) + "," + str(40) #put window in consistent location
os.environ['SDL_VIDEO_WINDOW_POS'] = str(0) + "," + str(40) #put window in consistent location

#image to blank out the bottom portion of the screen
line = [0]*(30)
blank = []
for i in range(0, x):
	blank.append(line)
blankimg = Img(blank, (0, 128))

#parse briefing file
briefs = readbrief("briefing.000")

##replace this with campaign variables
convo = briefs[3][0] #4, 0, first mission briefing

for c in convo:
	print c.character
	print c.background
	print c.otherval
	print "\n"

#exit()

draw_list = []
screen = pygame.display.set_mode((x*size_mult, y*size_mult))

font = pygame.font.SysFont("Tahoma Bold", 70)

faces = readfile("talking.vga")
briefing = readfile("briefing.vga")
recroom = readfile("recroom.vga")
title = readfile("title.vga")


#animate
#while screens are left
coni = 0
while coni < len(convo):

	draw_list = []

	con = convo[coni]
	
	#handle branching
	if len(con.branch) == 0:
		coni += 1
	else:	
		condition = con.branch[0]
		args = con.branch[1:].split(',')[:-1]

		#doesn't handle the various branches or multiple branch conditions correctly
		br = HandleBranch(condition, args)
		
		#if branch is true, advance to the branch
		if br:
			coni = int(args[-1])
			continue
		else:
			coni += 1
	
	
	if con.character-20 < len(characters) and con.character >= 20:
		character = characters[con.character-20]
	else:
		character = Default
		#break

	start_time = pygame.time.get_ticks()
	exp_end_time = pygame.time.get_ticks()
	mouth_end_time = pygame.time.get_ticks()
	frame_end_time = pygame.time.get_ticks()
	frames = []

	print "c: " + `con.character`
	print "b: " + `con.background`
	
	#get backgrounds
	if con.background == 255:
		pass
	
	elif con.background >=2 and con.background <= 4:
		if con.background == 2:
			draw_list.append(extract_image(title[6][1]))
		draw_list.append(extract_image(recroom[1][con.background-1]))
	
	elif con.background < 2:
		if con.background == 0:
			draw_list.append(extract_image(briefing[0][5]))
		elif con.background == 1:
			draw_list.append(extract_image(briefing[0][6]))
		draw_list[-1].location = [0,0]
		
	elif con.background >= 10:
		draw_list.append(extract_image(briefing[6][con.background-9]))
		
	#get character face
	if con.character >= 20 and con.character-20 < len(faces):
		face = extract_image(faces[con.character-20][1])
		draw_list.append(face)
		draw_list[-1].location = [0,0]
		
	else:
		face = None
		#0 should be animated, 1 should not
		if con.character == 0 or con.character == 1: #wide shot of briefing room
			draw_list.append(extract_image(briefing[0][1])) #background
			draw_list.append(extract_image(briefing[1][22])) #halcyon
			draw_list[-1].location = [233,46]
			draw_list.append(extract_image(briefing[1][23])) #podium
			draw_list[-1].location = [230,59]
			jacket = extract_image(briefing[4][1])
			draw_list.append(copy(jacket))
			draw_list[-1].location = [10,96]
			draw_list.append(copy(jacket))
			draw_list[-1].location = [98,96]
			draw_list.append(copy(jacket))
			draw_list[-1].location = [186,96]
			#add heads, front row of people
		elif con.character == 2: #midrange halcyon
			draw_list.append(extract_image(briefing[0][2])) #navmap background
			draw_list.append(extract_image(briefing[0][3])) #button background
			draw_list[-1].location[0] = x - len(draw_list[-1].image)
			draw_list[-2].location[0] = draw_list[-1].location[0] - len(draw_list[-2].image)
			draw_list.append(extract_image(briefing[2][1])) #halcyon
			draw_list[-1].location = [190, 18]
			draw_list.append(extract_image(briefing[0][4])) #podium
			draw_list[-1].location = [210, 128 - len(draw_list[-1].image[0])]
		elif con.character == 3:
			map = extract_image(briefing[0][2])
			button = extract_image(briefing[0][3])
			pod = extract_image(briefing[0][4])
			halframe = 1
			haldir = 1
			for j in range(0, len(button.image), 4):
				dlist = [map, button]
				hal = extract_image(briefing[2][halframe])
				
				if halframe < 16 and haldir == 1:
					halframe += 1
				elif halframe == 16 and haldir > 0 and haldir < 3:
					haldir += 1
				elif halframe == 16 and haldir == 3:
					haldir = 0
					halframe == 15
				elif haldir == 0:
					halframe -= 1
				
				hal.location = [190 + 9*j / 8, 18]
				dlist.append(hal)
				pod.location = [210 + 5*j/4, 128 - len(pod.image[0])]
				dlist.append(pod) #podium
			
				frames.append(pygame.Surface((x, y)))
				button.location = [x - len(button.image) + j, 0] #move button background to the far right
				map.location = [button.location[0] - len(map.image), 0] #move navmap background to the left

				for d in dlist:
					display_image(d.image, size_mult, bright_mult, frames[-1], d.location[0], d.location[1]+24)


	draw_list.append(blankimg)
	
	screen2 = pygame.Surface((x, y))
	#draw all images in the list
	for d in draw_list:
		display_image(d.image, size_mult, bright_mult, screen2, d.location[0], d.location[1]+24)
		
			
	#pygame.transform.smoothscale(screen2, (x*size_mult, y*size_mult), screen)
	pygame.transform.scale2x(pygame.transform.scale2x(screen2), screen)
	
	pygame.display.update()
		

	#define text to show
	color = character.textcolor
	words = con.text.split(' ')
	strs = ['']
	
	while len(words) > 0:
		#INTERPOLATE CORRECT VARIABLES
		if len(words[0]) > 0 and words[0][0] == '$':
			insert = InsertVars(words[0])
			words[0] = insert + words[0][2:]
		
		if len(strs[-1]) + len(words[0]) >= 51:
			strs.append('')
		strs[-1] += words.pop(0) + ' '
	
	fontsur = []
	for s in strs:
		fontsur.append(font.render(s, 1, color))
	
	#parse script
	#print con.script
	insts = con.script.split(',')
	insts[0] = insts[0][1:]
	insts = [i for i in insts if len(i) > 0]
	
	if len(insts) == 0:
		insts = ['09','09','09','09','09','09','09','09','09']
	print "i: " + `insts`
	
	#while instructions are left on this screen
	i = 0
	phonchar = 0
	framei = 0
	
	while i < len(insts):
		
		if pygame.event.poll().type == pygame.KEYDOWN:
			break
	
		inst = insts[i]
				
		#if it's time to end the previous animation
		if pygame.time.get_ticks() >= exp_end_time:
			if face != None:
		
				#draw blank face
				display_image(face.image, size_mult, bright_mult, screen2, 0, 24)
				display_image(blankimg.image, size_mult, bright_mult, screen2, blankimg.location[0], blankimg.location[1]+24)
				pygame.transform.scale2x(pygame.transform.scale2x(screen2), screen)
				for fi in range(0, len(fontsur)):
					f = fontsur[fi]
					screen.blit(f, (screen.get_width()/2 - f.get_width()/2, y*size_mult - 150 + 70 * fi))
				
				if inst == "":
					break
			
				#execute animation instruction (draw correct face)
				if inst[0].isalpha():
					expnum = 1
					exp = extract_image(faces[con.character-20][expnum])
					expx = 0
					expy = 24
				else:
					expnum = int(inst[0]) + 12
					exp = extract_image(faces[con.character-20][expnum])
					#location of expression is problematic
					expx = (x/2)-len(exp.image)/2 + character.eyepos[0]
					expy = (y/2)-len(exp.image[0]) +  character.eyepos[1]
					
				display_image(exp.image, size_mult, bright_mult, screen2, expx, expy)
			
			i += 1
			
			#record time to end new animation
			exp_end_time = pygame.time.get_ticks() + int(inst[1:])*50

		#make mouth move correctly
		#if it's time to advance to the next mouth movement
		if pygame.time.get_ticks() >= mouth_end_time:
			if con.character >= 20:
				#look at phon, character by character
				if phonchar < len(con.phon):
					c = con.phon[phonchar]
					phonchar += 1
				else:
					c = 'b'
				
				
				#if number, delay
				if c.isdigit():
					#draw basic mouth
					mouth = extract_image(faces[con.character-20][1])
					display_image(mouth.image, size_mult, bright_mult, screen2, 0, 24)
					mouth_end_time = pygame.time.get_ticks() + int(c) * 100
				#if letter, pull up correct expression
				elif c.isalpha():
					mouthnum = mouth_codes[ord(c)- 97]
					mouth = extract_image(faces[con.character-20][mouthnum])
				
					if mouthnum == 1:
						mouthx = 0
						mouthy = 24
					else:
						#calculate coordinates
						mouthx = (x/2)-len(mouth.image)/2 + character.mouthpos[0]
						mouthy = (y/2)-len(mouth.image[0]) +  character.mouthpos[1]
						#mouthx = (x/2)-len(mouth)/2
						#mouthy = y/2
						
					#draw correct expression
					display_image(mouth.image, size_mult, bright_mult, screen2, mouthx, mouthy)
					
					mouth_end_time = pygame.time.get_ticks() + 100

		display_image(blankimg.image, size_mult, bright_mult, screen2, blankimg.location[0], blankimg.location[1]+24)
		pygame.transform.scale2x(pygame.transform.scale2x(screen2), screen)
					
		if pygame.time.get_ticks() >= frame_end_time and framei < len(frames):
			pygame.transform.scale2x(pygame.transform.scale2x(frames[framei]), screen)
			framei += 1
			frame_end_time = pygame.time.get_ticks() + 50
			
		
		#write text to screen
		for fi in range(0, len(fontsur)):
			f = fontsur[fi]
			screen.blit(f, (screen.get_width()/2 - f.get_width()/2, y*size_mult - 150 + 70 * fi))
			
		pygame.display.update()
	