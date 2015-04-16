class Field:
	def __init__(self, (x,y,z), radius):
		self.coords = (x,y,z)
		self.radius = radius
		
class AsteroidField(Field)
class MineField(Field)

class NavPoint:
	def __init__(self, ships = (), fields = (), coords = (x,y,z), stealth_flag = 0):
		self.ships = ships
		self.fields = fields
		self.coords = (x,y,z)
		self.stealth_flag = stealth_flag
	
class FlightMission:
	def __init__(self, navpoints = (), navmap):
		self.navpoints = navpoints
		self.navmap = navmap
		
		
  