"""
This module defines the PilotCharacter and EnemyAce classes
"""

import types
import Rank
import TalkingHead
import FlightAI

class PilotCharacter:
	"""
	These are pilots who have their killscores tracked and, potentially, lines in the game
	"""	
	
	def __init__(self, firstname, lastname, callsign, mission_count=0, kill_count=0, prev_mission_kills=0, rank, talking_head, flight_AI, missions_killed = []):
		"""
		Initialize a new pilot with the data provided
		Assume the pilot to be alive when created
		"""
		
		#check for valid data types on each input
		if isinstance(firstname, (str, unicode)):
			self.firstname = firstname
		else:
			raise TypeError
		
		if isinstance(lastname, (str, unicode)):
			self.lastname = lastname
		else:
			raise TypeError
			
		if isinstance(callsign, (str, unicode)):
			self.callsign = callsign
		else:
			raise TypeError
		
		if isinstance(mission_count, types.IntType):
			self.mission_count = mission_count
		else:
			raise TypeError
		
		if isinstance(kill_count, types.IntType):
			self.kill_count = kill_count
		else:
			raise TypeError
		
		if isinstance(prev_mission_kills, types.IntType):
			self.prev_mission_kills = prev_mission_kills
		else:
			raise TypeError
			
		if isinstance(rank, Rank.Rank):
			self.rank = rank
		else:
			raise TypeError
			
		if isinstance(talking_head, TalkingHead.TalkingHead):
			self.talking_head = talking_head
		else:
			raise TypeError
			
		if isinstance(flight_AI, FlightAI.FlightAI):
			self.flight_AI = flight_AI
		else:
			raise TypeError
		
		self.missions_killed = missions_killed; #he's not dead!
		
	def Kill(self, current_mission):
		"""
		Kill this pilot, recording the mission where they died
		"""
		self.missions_killed.append(current_mission)
		
class EnemyAce:
	"""
	These are the enemy ace pilots
	They have names, callsigns, and AI
	Missions where they are spawned, encountered, and killed are tracked
	Aces being killed in multiple missions exists to support scenarios like ejection
	"""
	
	def __init__(self, name, callsign, flight_AI):
	
		if isinstance(name, (str, unicode)):
			self.name = name
		else:
			raise TypeError
		
		if isinstance(callsign, (str, unicode)):
			self.callsign = callsign
		else:
			raise TypeError
			
		if isinstance(flight_AI, FlightAI.FlightAI):
			self.flight_AI = flight_AI
		else:
			raise TypeError
			
		self.missions_spawned = []
		self.missions_encountered = []
		self.missions_killed = []
		
	def Spwan(self, current_mission):
		self.missions_spawned.append(current_mission)
	
	def Encounter(self, current_mission):
		"""
		Kill this pilot, recording the mission where they died
		"""
		self.missions_encountered.append(current_mission)
	
	def Kill(self, current_mission):
		"""
		Kill this ace, recording the mission where they died
		"""
		self.missions_killed.append(current_mission)
		