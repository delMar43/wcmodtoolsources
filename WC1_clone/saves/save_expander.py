class savegame:
	def __init__(self, name, junk, pilots, last_mission, info, zeroes, navs):
		self.name = name
		self.junk = junk
		self.pilots = pilots
		self.last_mission = last_mission
		self.info = info
		self.zeroes = zeroes
		self.navs = navs
		
class savepilot:
	def __init__(self, lastname, callsign, code1, rank, missions, kills, code2):
		self.lastname = lastname
		self.callsign = callsign
		self.code1 = code1
		self.rank = rank
		self.missions = missions
		self.kills = kills
		self.code2 = code2
		
class savemission:
	def __init__(self, unknown, medals, ribbons, mission, series, junk):
		self.unknown = unknown
		self.medals = medals
		self.ribbons = ribbons
		self.mission = mission
		self.series = series
		self.junk = junk

filename = "savegame.wld"
f = open(filename, 'rb')
str = f.read()
f.close()

blocks = []
for i in range(0, len(str), 828):
	blocks.append(str[i:i+828])

for b in blocks:
	name = b[0:b.index('\0')]
	junk = b[16:18]
	
	pilots = []
	for i in range(18, 360, 38):
		lastname = b[i:i+14] #strip whitespace?
		callsign = b[i+14:i+28] #strip whitespace?
		code1 = b[i+28:i+30]
		rank = b[i+30:i+32]
		missions = b[i+32:i+34]
		kills = b[i+34:i+36]
		code2 = b[i+36:i+38]
		pilots.append(savepilot(lastname, callsign, code1, rank, missions, kills, code2))
		
	unknown = b[360:364]
	medals = (x for x in b[364:369])
	ribbons = (x for x in b[369:381])
	missions = b[381]
	series = b[382]
	junk = b[383:392]
	last_mission = savemission(unknown , medals, ribbons, missions, series, junk)
	
	
	## more data
	
	zeroes = b[400:428]
	
	