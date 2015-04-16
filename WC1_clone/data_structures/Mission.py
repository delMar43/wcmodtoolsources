"""
Mission objectives aren't clearly defined yet
"""

class MissionObjective:
	def __init__(self, victory_points):
		self.victory_points = victory_points
		self.accomplished = 0

class NavObjective(MissionObjective)
	def __init__(self, victory_points, nav):
		MissionObjective.__init__(self, victory_points)
		self.nav = nav

class BaseObjective(MissionObjective):
	def __init__(self, victory_points, ship):
		MissionObjective.__init__(self, victory_points)
		self.ship = ship

class EscortObjective(MissionObjective)
	def __init__(self, victory_points, ship):
		MissionObjective.__init__(self, victory_points)
		self.ship = ship

class ReconObjective(MissionObjective)
	def __init__(self, victory_points, ship):
		MissionObjective.__init__(self, victory_points)
		self.ship = ship

class DestroyObjective(MissionObjective)
	def __init__(self, victory_points, ship):
		MissionObjective.__init__(self, victory_points)
		self.ship = ship
				
class MedalOpportunity:
	def __init__(self, medal_type, kill_points):
		self.medal_type = medal_type
		self.kill_points = kill_points

class Mission:
	def __init__(self, flight_mission, date, time, system_name, conversations = {}, objectives = (), medal_opportunity = None, left_bar = None, right_bar = None, ejected = 0, victory_point_req = 0):
		self.flight_mission = flight_mission
		self.date = date
		self.time = time
		self.system_name = system_name
		
		self.conversations = conversations #a dictionary indexed by conversation name; briefing, debriefing, bar conversations, etc.
		self.objectives = objectives
		self.medal_opportunity = medal_opportunity
		
		self.left_bar = left_bar
		self.right_bar = right_bar
		
		self.ejected = ejected
		self.victory_point_req = victory_point_req
		
class Series:
	def __init__(self, missions = (), victory_point_req = 0, wingman = None, win_series = None, win_ship = None, win_cutscene = None, lose_series = None, lose_ship = None, lose_cutscene = None):
		self.missions = missions
		self.victory_point_req = victory_point_req
		self.wingman = wingman
		
		self.win_series = win_series
		self.win_ship = win_ship
		self.win_cutscene = win_cutscene
		
		self.lose_series = lose_series
		self.lose_ship = lose_ship
		self.lose_cutscene = lose_cutscene
		
class Campaign:
	def __init(self, name, series = ()):
		self.name = name
		self.series = series
