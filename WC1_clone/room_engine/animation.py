from brief_expander import *
from graphic_expander import *
from game_structures import *
from win_init import *

#image to blank out the bottom portion of the screen
line = [0]*(30)
blank = []
for i in range(0, x):
	blank.append(line)
blankimg = Frame(Img(blank, (0, 128)))

class Frame:
	def __init__(self, image, x, y):
		self.image = image
		self.x = x
		self.y = y

class Animation:
	def __init__(self, fs = []):
		self.frames = fs
		
		for f in fs:
			tempscreen1 = pygame.Surface((x,y))
			tempscreen1.fill((0,0,255))
			display_image(f.image, size_mult, bright_mult, tempscreen1, f.x,f.y)
			f.image = tempscreen1
			f.image.set_colorkey((0,0,255))
		self.i = 0
		
	def Draw(self):
		f = self.frames[self.i]
		screen2.blit(f.image, (0,0))
		
		self.i += 1 #advance the frame pointer
		if self.i == len(self.frames):
			self.i = 0
			
class Conversation2:
	def __init__(self, series = 0, mission = 0, con_i = 0): #con_i: 0: briefing, 1: debriefing, 2: shotglass, 3: right seat, 4: left seat
		self.series = series
		self.mission = mission
		self.con_i = con_i
				
		briefing = readfile("briefing.vga")
		briefs = readbrief("briefing.000")
		
		self.convo = briefs[series*4 + mission][con_i]
		self.anis = []
		
		coni = 0
		while coni < len(self.convo):
			frames = []
			
			con = self.convo[coni] #pick this animation
			
			#handle branching
			if len(con.branch) == 0: #if there is no branching condition, move on with the next animation
				coni += 1
				continue
				
			condition = con.branch[0]
			args = con.branch[1:].split(',')[:-1]

			#doesn't handle the various branches or multiple branch conditions correctly
			br = HandleBranch(condition, args)
			
			#if branch is true, advance to the branch
			if br:
				coni = int(args[-1])
				continue
			else: #if branch is false, move on to the next animation
				coni += 1
				
			if con.character-20 < len(characters) and con.character >= 20:
				character = characters[con.character-20]
			else:
				character = Default
				#break
				
			#get backgrounds
			if con.background == 255:
				pass
			
			elif con.background >=2 and con.background <= 4:
				if con.background == 2:
					frames.append(Frame(extract_image(title[6][1]).image, 0, 0))
				frames.append(Frame(extract_image(recroom[1][con.background-1])))
			
			elif con.background < 2:
				if con.background == 0:
					frames.append(Frame(extract_image(briefing[0][5])))
				elif con.background == 1:
					frames.append(Frame(extract_image(briefing[0][6]), 0, 0))
				
			elif con.background >= 10:
				frames.append(Frame(extract_image(briefing[6][con.background-9])))
				
			#get character face
			if con.character >= 20 and con.character-20 < len(faces):
				face = Frame(extract_image(faces[con.character-20][1]))
				frames.append(face)
				frames[-1].x = 0
				frames[-1].y = 0
				
			else:
				face = None
				#0 should be animated, 1 should not
				if con.character == 0 or con.character == 1: #wide shot of briefing room
					frames.append(Frame(extract_image(briefing[0][1]))) #background
					frames.append(Frame(extract_image(briefing[1][22]), 233, 46)) #halcyon
					frames.append(Frame(extract_image(briefing[1][22]), 230, 59)) #podium
					
					jacket = Frame(extract_image(briefing[4][1]))
					frames.append(copy(jacket))
					frames[-1].x = 10
					frames[-1].y = 96
					frames.append(copy(jacket))
					frames[-1].x = 98
					frames[-1].y = 96
					frames.append(copy(jacket))
					frames[-1].x = 186
					frames[-1].y = 96
					
				#add heads, front row of people
				elif con.character == 2: #midrange halcyon
					frames.append(Frame(extract_image(briefing[0][2]))) #navmap background
					frames.append(Frame(extract_image(briefing[0][3]))) #button background
					frames[-1].x = x - len(frames[-1].image)
					frames[-2].x = frames[-1].x - len(frames[-2].image)
					
					frames.append(Frame(extract_image(briefing[2][1]), 190, 18)) #halcyon
					frames.append(Frame(extract_image(briefing[0][4]), 210, 128 - len(frames[-1].image[0]))) #podium
					
				elif con.character == 3:
					map =  Frame(extract_image(briefing[0][2]), 0, 0)
					button =  Frame(extract_image(briefing[0][3]), 0, 0)
					pod =  Frame(extract_image(briefing[0][4]))
					halframe = 1
					haldir = 1
					
					for j in range(0, len(button.image), 4):
						dlist = [map, button]
						hal = Frame(extract_image(briefing[2][halframe]), 0, 18)
						
						if halframe < 16 and haldir == 1:
							halframe += 1
						elif halframe == 16 and haldir > 0 and haldir < 3:
							haldir += 1
						elif halframe == 16 and haldir == 3:
							haldir = 0
							halframe == 15
						elif haldir == 0:
							halframe -= 1
					
						hal.x = 190 + 9*j / 8,
						
						dlist.append(hal)
						pod.x = 210 + 5*j/4
						pod.y = 128 - len(pod.image[0])
						dlist.append(pod) #podium
					
						button.x = x - len(button.image) + j
						map.x = button.x - len(map.image) #move navmap background to the left

						for f in frame_list:
							screen2.blit(f.image, f.x,f.y+24)
				
			##add blank part of screen
				
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
				inst = insts[i]
				if face != None:
					
				
				
			
			self.anis.append(Animation(frames))
		
	def Play(self):

			start_time = pygame.time.get_ticks()
			exp_end_time = pygame.time.get_ticks()
			mouth_end_time = pygame.time.get_ticks()
			frame_end_time = pygame.time.get_ticks()

			while i < len(insts):
				
				inst = insts[i]
						
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