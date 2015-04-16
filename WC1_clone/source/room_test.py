from brief_expander import *
from graphic_expander import *
from game_structures import *
from head_class import *
from save_expander import *
import os
import sys


##define objects for recroom, killboard, medals
##restructure conversations as animations
##make animations follow defined patterns in game
##add music

mission = 5

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

class Room:
	def __init__(self, draw_list = []):
		#define a 2-d list of hotspots
		self.spots = []
		for i in range(0, x*size_mult):
			self.spots.append([None]*y*size_mult)
		
		#define the background
		self.draw_list = draw_list
		for d in self.draw_list:
			tempscreen1 = pygame.Surface((x,y))
			tempscreen1.fill((0,0,255))
			display_image(d.image, size_mult, bright_mult, tempscreen1, d.x,d.y)
			d.image = tempscreen1
			d.image.set_colorkey((0,0,255))
		
		self.anim_list = []

	#add a click box to the room
	def AddClickBox(self, x, y, width, height, dest, label = ""):
		for i in range(x, x+width):
			self.spots[i][y:y+height] = [(dest, label)]*height
			
	def Display(self):
		screen2.fill((0,0,0))
		for i in self.draw_list:
			screen2.blit(i.image, (0,0))
	
	def Animate(self):
		self.Display()
		for a in self.anim_list:
			a.Draw()
			
	
	def __call__(self):
		global pres_room
		pres_room = self;
		self.Display()

class Scene(Room):
	def __init__(self, background, home):
		Room.__init__(self, [background])
		self.AddClickBox(0, 0, x*size_mult, y*size_mult, home)
	
class Killboard(Scene):
	def Display(self):
		Scene.Display(self)
		##draw actual kills on the board

class Medals(Scene):
	def Display(self):
		##blank screen
		display_image(self.background, size_mult, bright_mult, screen2, 400, 0)
		pygame.transform.scale2x(pygame.transform.scale2x(screen2), screen)
		##draw various medals
		##print text below
		
class Recroom(Room):
	def __init__(self):
		global mission
	
		Room.__init__(self)
		
		framelist = [Frame(extract_image(recgraphs[0][1]).image, 0, 0)] #background
		
		#open mission, see which pilots should be here
		seats = readfile("camp.000", [2])[2]
		lefti, righti = seats[(mission-4)*2:(mission-3)*2]
		
		shotglass = Conversation(mission, 2)
		right_pilot = Conversation(mission, 3)
		left_pilot = Conversation(mission, 4)
		
		self.AddClickBox(375, 220, 165, 165, shotglass, "Talk to SHOTGLASS.")

		if lefti == 255:
			leftpilot = None
		else:
			leftpilot = barfaces[lefti]
			
		if righti == 255:
			rightpilot = None
		else:
			rightpilot = barfaces[righti]
		
		if leftpilot != None and leftpilot.diedin == -1:
			label = "Talk to " + leftpilot.callsign.upper() + "."
			self.AddClickBox(630, 300, 185, 170, left_pilot, label)
			framelist.append(Frame(extract_image(recgraphs[3+lefti][1]).image, 160, 79))
			temp = []
			for i in recgraphs[3+lefti][1:]:
				temp.append(Frame(extract_image(i).image, 160, 79))
			self.anim_list.append(Animation(temp))

		if rightpilot != None and rightpilot.diedin == -1: #if the right pilot is set and not dead
			label = "Talk to " + rightpilot.callsign.upper() + "." #label correctly
			self.AddClickBox(815, 300, 185, 170, right_pilot, label) #make the pilot clickable
			framelist.append(Frame(extract_image(recgraphs[3+righti][1]).image, 202, 79)) #add the primary display frame
			temp = []
			for i in recgraphs[3+righti][1:]:
				temp.append(Frame(extract_image(i).image, 202, 79))
			self.anim_list.append(Animation(temp)) #add the animated frames
			
		if leftpilot != None and rightpilot != None:
			framelist.append(Frame(extract_image(recgraphs[0][4]).image, 158, 128)) #draw both feet
			
		elif leftpilot != None:
			framelist.append(Frame(extract_image(recgraphs[0][3]).image, 158, 128)) #draw left feet
			
		elif rightpilot != None:
			framelist.append(Frame(extract_image(recgraphs[0][2]).image, 158, 128)) #draw right feet

		#draw shotglass
		temp = []
		for i in recgraphs[11][1:]:
			temp.append(Frame(extract_image(i).image, 94, 59))
		self.anim_list.append(Animation(temp))
		
		self.draw_list = framelist
		for d in self.draw_list:
			tempscreen1 = pygame.Surface((x,y))
			tempscreen1.fill((0,0,255))
			display_image(d.image, size_mult, bright_mult, tempscreen1, d.x,d.y)
			d.image = tempscreen1
			d.image.set_colorkey((0,0,255))
		
		self.Animate()
		
class Barracks(Room):
	def __init__(self):
		Room.__init__(self)
		
		self.background = Frame(extract_image(recgraphs[12][1]).image, 0, 0)
		framelist = [self.background] #background
		
		self.AddClickBox(1150, 140, 100, 190, Conversation(mission, 0), "Talk to SHOTGLASS.")
		self.AddClickBox(848, 120, 100, 220, sys.exit, "Talk to SHOTGLASS.")
				
		for s in savesys.saves:
			if s != None:
				##draw bodies, status, new clickboxes as appropriate
		
		#bucket
		temp = []
		for i in recgraphs[12][38:50]:
			temp.append(Frame(extract_image(i).image, 290, 139))
		self.anim_list.append(Animation(temp))
		
		#flickering light
		temp = [Frame(extract_image(recgraphs[12][1]).image, 0, 0)] #have to extract background again, not sure why
		flicker = Frame(extract_image(recgraphs[12][27]).image, 45, 0)
		temp.append(flicker)
		self.anim_list.append(Animation(temp))
		
		##add animations
		###red light
		###green light
		###drip
		###lifesign bars
				
		self.draw_list = framelist
		for d in self.draw_list:
			tempscreen1 = pygame.Surface((x,y))
			tempscreen1.fill((0,0,255))
			display_image(d.image, size_mult, bright_mult, tempscreen1, d.x,d.y)
			d.image = tempscreen1
			d.image.set_colorkey((0,0,255))
		
		self.Animate()

#make cursor correct
pygame.mouse.set_cursor((8,8),(0,0),(0,0,0,0,0,0,0,0),(0,0,0,0,0,0,0,0))

cursors = readfile("arrow.vga")
arrow = extract_image(cursors[0][1])
crosshairs = extract_image(cursors[0][2])

arrow_w = 9
arrow_h = 13
arrow_surf1 = pygame.Surface((arrow_w, arrow_h))
display_image(arrow.image, size_mult, bright_mult, arrow_surf1, 0, 0)
arrow_surf = pygame.Surface((arrow_w*size_mult, arrow_h*size_mult))
#pygame.transform.smoothscale(arrow_surf1, (arrow_w*size_mult, arrow_h*size_mult), arrow_surf)
pygame.transform.scale2x(pygame.transform.scale2x(arrow_surf1), arrow_surf)
arrow_surf.set_colorkey((0,0,255))

cross_w = 11
cross_h = 11
cross_surf1 = pygame.Surface((cross_w, cross_h))
display_image(crosshairs.image, size_mult, bright_mult, cross_surf1, 0, 0)
cross_surf = pygame.Surface((cross_w*size_mult, cross_h*size_mult))
#pygame.transform.smoothscale(arrow_surf1, (arrow_w*size_mult, arrow_h*size_mult), arrow_surf)
pygame.transform.scale2x(pygame.transform.scale2x(cross_surf1), cross_surf)
cross_surf.set_colorkey((0,0,255))

screen2 = pygame.Surface((x,y))

pres_room = None

recgraphs = readfile("recroom.vga")
unifgraphs = readfile("briefing.vga")

recroom = Recroom() 
barracks = Barracks()

killboard = Scene(Frame(extract_image(recgraphs[2][1]).image, 0, 0), recroom)
simulator = Scene(Frame(extract_image(recgraphs[2][1]).image, 0, 0), recroom)
medals = Scene(Frame(extract_image(unifgraphs[8][12]).image, 0, 0), barracks)

barracks.AddClickBox(30, 110, 140, 240, recroom, "Return to the Bar")
barracks.AddClickBox(340, 170, 390, 140, medals, "View your medals")


recroom.AddClickBox(700, 160, 300, 160, killboard, "Check pilot scores")
recroom.AddClickBox(1100, 160, 180, 380, barracks, "Enter barracks")
recroom.AddClickBox(0, 395, 475, 340, barracks, "Fly training mission")

font = pygame.font.SysFont("Tahoma Bold", 70)

barracks()

frame_end_time = pygame.time.get_ticks() + 250

while True:
	for event in pygame.event.get():
		if event.type==QUIT:
			exit()
			
		elif event.type == pygame.MOUSEBUTTONDOWN:
			spot = pres_room.spots[event.pos[0]][event.pos[1]]
			if spot:
				spot[0]()
	
	#pygame.transform.smoothscale(screen2, (x*size_mult, y*size_mult), screen)
	pygame.transform.scale2x(pygame.transform.scale2x(screen2), screen)
	mousex, mousey = pygame.mouse.get_pos()
	#print mousex, mousey
	
	if pygame.time.get_ticks() >= frame_end_time:
		frame_end_time = pygame.time.get_ticks() + 250
		pres_room.Animate()
	
	#draw mouse pointer correctly
	if mousex < x*size_mult and mousey < y*size_mult:
		if isinstance(pres_room, Scene):
			pass
		else:
			if pres_room.spots[mousex][mousey]:
				screen.blit(cross_surf, (mousex, mousey))
				fontsur = font.render(pres_room.spots[mousex][mousey][1], 1, (255, 255, 255))
				screen.blit(fontsur, (x*size_mult/2 - fontsur.get_rect().right/2, y*size_mult-50))
			else:
				screen.blit(arrow_surf, (mousex, mousey))
				print mousex, mousey
	
	pygame.display.update()