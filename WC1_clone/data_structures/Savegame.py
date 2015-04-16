class Savegame:
	def __init__(self, name, gamestate):
		self.name = name
		self.gamestate = gamestate
		self.prev_gamestate = None
		
class SavegameSystem:
	def __init__(self, savegames = []):
		self.savegames = savegames