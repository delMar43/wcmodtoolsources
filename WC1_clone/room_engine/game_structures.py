NUMPILOTS = 8
NUMACES = 4
NUMOBJECTIVES = 16

ranks = ("2ND LT", "1ND LT", "CAPTAIN", "MAJOR", "LT COL", )
rib_names = ['ACAD', 'FLTS', 'VEGA', 'HORN', 'RPIR', 'SCIM', 'RAPT', 'ACE', 'AOFA', '5 M', '10 M', '15M']

class Character:
	def __init__(self, mouthpos=(0,0), eyepos=(0,0), textcolor=(255,255,255)):
		self.mouthpos = mouthpos
		self.eyepos = eyepos
		self.textcolor = textcolor

#coordinates are relative to center of screen
class Pilot(Character):
	def __init__(self, callsign, name, rank=0, diedin=-1, kills=0, missions=0, mouthpos = (0,0), eyepos=(0,0), textcolor = (255, 255, 255)):
		self.callsign = callsign
		self.name = name
		self.rank = rank
		self.diedin = diedin
		self.kills = kills
		self.missions = missions
		self.mouthpos = mouthpos
		self.eyepos = eyepos
		self.textcolor = textcolor	
		
class Player(Pilot): 
	def __init__(self, callsign, name, rank=0, diedin=-1, kills=0, missions=0, mouthpos = (0,0), eyepos=(0,0), textcolor = (255, 255, 255)):
		global rib_names
	
		Pilot.__init__(self, callsign, name, rank, diedin, kills, missions, mouthpos, eyepos, textcolor)

		self.bronzestars = 0
		self.silverstars = 0
		self.goldstars = 0
		self.goldsun = 0
		self.pewter = 0
		
		self.promotion_points = 0
		self.victory_points = 0
		self.series = 0 #not sure what this is, didn't document well enough
		
		self.ribbons= {}
		for r in rib_names:
			self.ribbons[r] = 0
		
		

class Ace:
	def __init__(self, name, diedin = -1):
		self.name = name
		self.diedin = diedin
	
class Mission:
	def __init__(self, ship=0, playerkills=0, wingmankills=[0] * NUMPILOTS, good=0, postmeeting=0, objsuccess=[0] * NUMOBJECTIVES, objsighted=[0] * NUMOBJECTIVES, medal=0, promotion=0, ejection=0, total_ejections=0, transfer=0):
		self.ship = ship
		self.playerkills = playerkills
		self.wingmankills = wingmankills
		self.good = good
		self.postmeeting = postmeeting
		self.objsuccess = objsuccess
		self.objsighted = objsighted
		self.medal = medal
		self.promotion = promotion
		self.ejection = ejection
		self.total_ejections = total_ejections
		self.transfer = transfer
		
Halcyon = Character((0,42), (0,-2), (100, 100, 100)) #perfect
Spirit = Pilot("Spirit", "Tanaka", 1, -1, 0, 0, (2,37), (0,-3), (132, 112, 255)) #perfect
Hunter = Pilot("Hunter", "St.John", 2, -1, 0, 0, (22,46), (13,-2), (65, 105, 225)) #perfect
Bossman = Pilot("Bossman", "Chen", 3, -1, 0, 0, (-16,42), (-11,-6), (150, 0, 0)) #eyes slightly off?
Iceman = Pilot("Iceman", "Casey", 3, -1, 0, 0, (9,46), (4,-5), (0, 200, 200)) #perfect
Angel = Pilot("Angel", "Devereaux", 2, -1, 0, 0, (-8,46), (-2,6), (250, 218, 185)) #mouth slightly off?
Paladin = Pilot("Paladin", "Taggart", 3, -1, 0, 0, (0,44), (-5,-3), (0, 0, 200)) #mouth slightly off?
Maniac = Pilot("Maniac", "Marshall", 0, -1, 0, 0, (0,45), (0,0), (0, 200, 0)) #perfect
Knight = Pilot("Knight", "Khumalo", 2, -1, 0, 0, (2,43), (2,-3), (100, 40, 40)) #perfect
Bluehair = Player("Omega", "Blair", 0, -1, 0, 0, (0,46), (0,0), (255, 255, 0)) #check eyes
Shotglass = Character((0,43), (0,2), (107, 142, 35)) #perfect
characters = (Halcyon, Spirit, Hunter, Bossman, Iceman, Angel, Paladin, Maniac, Knight, Bluehair, Shotglass)
barfaces = (Spirit, Hunter, Bossman, Iceman, Angel, Paladin, Maniac, Knight)
pilots = (Spirit, Hunter, Bossman, Iceman, Angel, Paladin, Maniac, Knight, Bluehair)

Default = Character((0,43), (0,2), (107, 142, 35))

Starkiller = Ace("Bhurak Starkiller")
Deathstroke = Ace("Dakhath Deathstroke")
Fang = Ace("Khajja the Fang")
Redclaw = Ace("Baron Bakhtosh Redclaw")
aces = (Starkiller, Deathstroke, Fang, Redclaw)

#create a single mission for the tree, just for experimenting
missions = (Mission())
curr_mission = 0

mission_i = 0 #indexed from 0
series_i = 1 #indexed from 1, to match game files
date = 0
year = 0

missiond = [] #undecoded data about nav points in each mission



