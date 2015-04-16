import game_structures
from block_expander import conv_endian
from copy import copy

##to do:
##check to see if the system correctly transforms between saving and loading

class Savesystem:
	def __init__(self, filename = "savegame.wld"):
		self.saves = []
		self.filename = filename
		
		# open the save file
		f = open(filename, 'rb')
		str = f.read()
		f.close()
		
		slots = []
		for i in range(0, len(str), 828):
			slots.append(str[i:i+828])
		
		for s in slots:
			name = s[0:s[0:16].find("\0")]
			#see which saved games exist
			if (name[0:5] != "game "):
				#instantiate those games in the list
				self.saves.append(Savegame(name, s))
			else:
				self.saves.append(None)

	def Load(self, i=None):
		if (i is None):
			print "specify a game to load"
		elif i >= len(self.saves):
			print "index too large"
		elif self.saves[i] is None:
			print "slot empty"
		else:
			self.saves[i].Load()
			
	def Save(self, i=None):
		if (i is None):
			print "specify a game to save"
		elif i >= len(self.saves):
			print "index too large"
		else:
			saved = self.saves[i].Save()
			
			# open the save file
			f = open(self.filename, 'rb')
			str = f.read()
			f.close()
			
			##overwrite the appropriate chunk of str with saved
			
			#rewrite that chunk of the wld file
			f = open(self.filename, 'wb')
			f.write(str)
			f.close()
				
class Savegame:
	def __init__(self, name, data):
		self.savename = name
		self.data = data
		
	def Save(self):
		#parse game structures into outd
		outd = ""
		
		outd = self.savename.ljust(18, "\0")
		
		for p in game_structures.pilots:
			outd +=  p.name.ljust(14, "\0")
			outd +=  p.callsign.ljust(14, "\0")
			outd += "\0\0" #unknown
			
			outd += chr(p.rank%256) + chr(p.rank/256)
			outd += chr(p.missions%256) + chr(p.missions/256)
			outd += chr(p.kills%256) + chr(p.kills/256)
			
			outd += "\0\0" #unknown
		
		outd += chr(0x42) + chr(0x9A) + chr(0x00) + chr(0x00)
		
		pl = game_structures.Bluehair
		outd += chr(pl.bronzestars)
		outd += chr(pl.silverstars)
		outd += chr(pl.goldstars)
		outd += chr(pl.goldsun)
		outd += chr(pl.pewter)
		
		for r in range(0, len(game_structures.rib_names)):
			outd += chr(pl.ribbons[game_structures.rib_names[r]])
			
		outd += chr(game_structures.mission_i)
		outd += chr(game_structures.series_i)
		outd += chr(0x00)*9
		
		for p in game_structures.pilots[:-1]:
			if p.diedin == -1:
				diedin = 0
			else:
				diedin = 10
			outd += chr(diedin%256) + chr(diedin/256)
			
		for a in game_structures.aces:
			if a.diedin == -1:
				diedin = 0
			else:
				diedin = 10
			outd += chr(diedin) 
			
		outd += chr(game_structures.date%256) + chr(game_structures.date/256)
		outd += chr(game_structures.year%256) + chr(game_structures.year/256)
		
		#unknown
		outd += chr(0x06) + chr(0x00) + chr(0x00) + chr(0x00)
		
		outd += chr(pl.promotion_points%256) + chr(pl.promotion_points/256)
		outd += chr(0x00) + chr(0x00) #unknown
		outd += chr(pl.victory_points%256) + chr(pl.victory_points/256)
		outd += chr(pl.series%256) + chr(pl.series/256)
		
		for m in game_structures.missiond:
			for n in m:
				outd +=  n
		
		return outd
	
	def Load(self):
		#parse self.data into game structures
		pilotd = self.data[18:360]
		ps = []
		for i in range(0, len(pilotd), 38):
			ps.append(pilotd[i:i+38])
			
		for i in range(0, len(ps)):
			p = ps[i]
			name = p[0:p[0:14].find("\0")]
			callsign = p[14:14+p[14:28].find("\0")]
			#28-30 unknown			
			rank = conv_endian([ord(b) for b in p[30:32]], 0, 2)
			missions = conv_endian([ord(b) for b in p[32:34]], 0, 2)
			kills = conv_endian([ord(b) for b in p[34:36]], 0, 2)
			#36-38 unkown
			
			game_structures.pilots[i].name = name
			game_structures.pilots[i].callsign = callsign
			game_structures.pilots[i].rank = rank
			game_structures.pilots[i].rank = missions
			game_structures.pilots[i].rank = kills
			
		#360-363 unknown
		pl = game_structures.Bluehair
		pl.bronzestars = ord(self.data[364])
		pl.silverstars = ord(self.data[365])
		pl.goldstars = ord(self.data[366])
		pl.goldsuns = ord(self.data[367])
		pl.pewter = ord(self.data[368])
		
		ribbons = [ord(b) for b in self.data[369:381]]
		for r in range(0, len(ribbons)):
			pl.ribbons[game_structures.rib_names[r]] = ribbons[r]
			
		game_structures.mission_i = ord(self.data[381])
		game_structures.series_i = ord(self.data[382])
		
		#383-391 unknown
		
		##pilot and ace deaths may not be recorded correctly
		pdeaths = self.data[392:408]
		for i in range(0, 8):
			game_structures.pilots[i].diedin = conv_endian([ord(b) for b in pdeaths[i:i+2]], 0, 2)
		
		adeaths = self.data[408:412]
		for i in range(0, 4):
			game_structures.aces[i].diedin = ord(adeaths[i])
			
		game_structures.date = conv_endian([ord(b) for b in self.data[412:414]], 0, 2)
		game_structures.year = conv_endian([ord(b) for b in self.data[414:416]], 0, 2)
		
		#416-419 unknown
		
		pl.promotion_points = conv_endian([ord(b) for b in self.data[420:422]], 0, 2)
		#422-423 uknown
		pl.victory_points = conv_endian([ord(b) for b in self.data[424:426]], 0, 2)
		pl.series = conv_endian([ord(b) for b in self.data[426:428]], 0, 2)
		
		#it appears that the saved games store 400 bytes, 100 for each mission in the series
		#it further appears that these 100 bytes are divided into four 25-byte chunks, one for each nav point in thie mission
		#the exact structure of these 25 bytes is still undetermined
		##should compare these 25 bytes to any unidentified branching structures and mission flags
		missiond = self.data[428:828]
		ms = []
		for i in range(0, len(missiond), 100):
			ms.append(missiond[i:i+100])
			
		for m in ms:
			navd = []
			for i in range(0, len(m), 25):
				navd.append(m[i:i+25])
			
			game_structures.missiond.append(copy(navd))
		
savesys = Savesystem("savegame.wld")
#savesys.Load(6)
#savesys.Save(6)
