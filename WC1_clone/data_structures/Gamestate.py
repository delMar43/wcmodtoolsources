class Gamestate:
	"""def __init__(self, pilots = [], aces = [], campaign, series, mission, kill_points = 0, victory_points = 0, promotion_points = 0, promotion_point_limit = None, prev_date = None, prev_kills = 0, wingman_prev_kills = 0, medal_awarding = None, ejection_count = 0):
		self.pilots = pilots
		self.aces = aces
		self.campaign = campaign
		self.series = series
		self.mission = mission
		self.kill_points = kill_points
		self.victory_points = victory_points
		self.promotion_points = promotion_points
		self.promotion_point_limit = promotion_point_limit
		self.prev_date = prev_date
		self.prev_kills = prev_kills
		self.wingman_prev_kills = wingman_prev_kills
		self.medal_awarding = medal_awarding
		self.ejection_count = ejection_count
	
		self.prev_gamestate = None
	"""
	
	def __init__(self, block):
		
		self.name = "".join([chr(x) for x in block[0:16]]).split("\0")[0]
		
		self.pilots = [] ##need to add this
		
		#self.mission = block[381]
		#self.series = block[382]
	
		self.prev_gamestate = None
		
	def Save(self, savegame, name):
		savegame.prev_gamestate = copy(savegame.gamestate) #backup, in case of accidental game overwrite
		savegame.gamestate = copy(self)
		savegame.name = name
	
	def Load(self, savegame):
		self.prev_gamestate = copy(self) #backup, in case of accidental overwrite
	
		self.pilots = savegame.gamestate.pilots
		self.aces = savegame.gamestate.aces
		self.campaign = savegame.gamestate.campaign
		self.series = savegame.gamestate.series
		self.mission = savegame.gamestate.mission
		self.kill_points = savegame.gamestate.kill_points
		self.victory_points = savegame.gamestate.victory_points
		self.promotion_points = savegame.gamestate.promotion_points
		self.promotion_point_limit = savegame.gamestate.promotion_point_limit
		self.prev_date = savegame.gamestate.prev_date
		self.prev_kills = savegame.gamestate.prev_kills
		self.wingman_prev_kills = savegame.gamestate.wingman_prev_kills
		self.medal_awarding = savegame.gamestate.medal_awarding
		self.ejection_count = savegame.gamestate.ejection_count