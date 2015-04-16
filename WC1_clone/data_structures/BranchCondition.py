class BranchCondition:
	def __init__(self, destination, arguments = ()):
		self.destination = destination
		self.arguments = arguments
		
	def Eval(self):
		return self.destination

#condition 1		
class BranchUnconditional(BranchCondition)

#condition 4
class BranchPilotDead(BranchCondition):
	def Eval(self):
		if len(gamestate.pilots[self.arguments[0]].missions_killed) != 0:
			return self.destination
		else:
			return None

#condition 5
class BranchPilotAlive(BranchCondition):
	def Eval(self):
		if len(gamestate.pilots[self.arguments[0]].missions_killed) == 0:
			return self.destination
		else:
			return None

#represents no existing branch, included for mathematical completeness
class BranchPilotKillsLess(BranchCondition):
	def Eval(self):
		if gamestate.pilots[self.arguments[0]].prev_mission_kills == self.arguments[1]:
			return self.destination
		else:
			return None
			
#should represent 6 and 8, with added flexibility for required killscores other than 0			
class BranchPilotKillsEqual(BranchCondition):
	def Eval(self):
		if gamestate.pilots[self.arguments[0]].prev_mission_kills == self.arguments[1]:
			return self.destination
		else:
			return None

#should represent 7 and 9, with added flexibility for required killscores other than 0			
class BranchPilotKillsGreater(BranchCondition):
	def Eval(self):
		if gamestate.pilots[self.arguments[0]].prev_mission_kills > self.arguments[1]:
			return self.destination
		else:
			return None

#condition 11
class BranchObjectiveFailed(BranchCondition):
	def Eval(self):
		if gamestate.mission.objectives[self.arguments[0]].accomplished == 0:
			return self.destination
		else:
			return None
	
#condition 12
class BranchObjectiveAccomplished(BranchCondition):
	def Eval(self):
		if gamestate.mission.objectives[self.arguments[0]].accomplished != 0:
			return self.destination
		else:
			return None
			
#represents no existing branch, included for mathematical completeness
class BranchEjectionCountLess(BranchCondition):
	def Eval(self):
		if gamestate.ejection_count < self.arguments[0]:
			return self.destination
		else:
			return None

#condition 16
class BranchNotPromoted(BranchCondition):
	def Eval(self):
		if gamestate.promotion_points < gamestate.promotion_point_limit:
			return self.destination
		else:
			return None
			
#condition 17
class BranchEjectedPrevious(BranchCondition):
	def Eval(self):
		if gamestate.mission.ejected:
			return self.destination
		else:
			return None
			
#should represent 18, with added flexibility for counts other than zero
class BranchEjectionCountEqual(BranchCondition):
	def Eval(self):
		if gamestate.ejection_count == self.arguments[0]:
			return self.destination
		else:
			return None

#should represent 26, with added flexibility for counts other than zero			
class BranchEjectionCountGreater(BranchCondition):
	def Eval(self):
		if gamestate.ejection_count > self.arguments[0]:
			return self.destination
		else:
			return None

#condition 27
class BranchObjectiveSighted(BranchCondition):
	def Eval(self):
		if gamestate.mission.objectives[self.arguments[0]].sighted != 0:
			return self.destination
		else:
			return None
	
#condition 28
class BranchObjectiveNotSighted(BranchCondition):
	def Eval(self):
		if gamestate.mission.objectives[self.arguments[0]].sighted == 0:
			return self.destination
		else:
			return None
			
#condition 29
class BranchPilotDiedPrevious(BranchCondition):
	def Eval(self):
		if gamestate.mission in gamestate.pilots[self.arguments[0]].missions_killed:
			return self.destination
		else:
			return None
			
#condition 30
class BranchPilotSurvivedPrevious(BranchCondition):
	def Eval(self):
		if gamestate.mission not in gamestate.pilots[self.arguments[0]].missions_killed:
			return self.destination
		else:
			return None
			
			
#condition 31
class BranchAceDead(BranchCondition):
	def Eval(self):
		if len(gamestate.aces[self.arguments[0]].missions_killed) != 0:
			return self.destination
		else:
			return None

#condition 32
class BranchAceSurvivedPrevious(BranchCondition):
	def Eval(self):
		if gamestate.mission not in gamestate.aces[self.arguments[0]].missions_killed:
			return self.destination
		else:
			return None			
			
#condition 33
class BranchAceAlive(BranchCondition):
	def Eval(self):
		if len(gamestate.aces[self.arguments[0]].missions_killed) == 0:
			return self.destination
		else:
			return None
			
#condition 34
class BranchAceDiedPrevious(BranchCondition):
	def Eval(self):
		if gamestate.mission in gamestate.aces[self.arguments[0]].missions_killed:
			return self.destination
		else:
			return None
			
"""			
	1: Unconditional, always branch
2(X): Branch if mission didn't go well?  Damage above a certain threshhold?
3(X): Branch if mission went well?  Damage below a certain threshhold?
	4(X): Branch if pilot X is dead
	5(X): Branch if pilot X is alive
	6: Branch if player kills last mission == 0
	7: Branch if player kills last mission > 0
	8(X): Branch if pilot X kills last mission == 0
	9(X): Branch if pilot X kills last mission > 0
10: Branch if no meeting with Halcyon after debriefing
	11(X): Branch if objective X failed
	12(X): Branch if objective X succeeded
13: Branch if receiving Pewter Planet
14: Branch if receiving Bronze/Silver/Gold Star
15: Branch if receiving Golden Sun
	16: Branch if not promoted
	17: Branch if didn't eject this mission
	18: Branch if first ejection (Golden Sun)
19: Branch if not transferring squadrons
20: Branch if not transferring to Hornet
21: Branch if not transferring to Scimitar
22: Branch if not transferring to Raptor
23: Branch if not transferring to Rapier
24: Branch if transfer to worse ship
25: Branch if transfer to better ship
	26: Branch if not first ejection
	27(X): Branch if objective X sighted
	28(X): Branch if objective X not sighted
	29(X): Branch if pilot X did not die this mission
	30(X): Branch if pilot X died this mission
	31(X): Branch if Kilrathi ace dead
	32(X): Branch if Kilrathi ace survived previous mission
	33(X): Branch if Kilrathi ace alive
	34(X): Branch if Kilrathi ace died in previous mission
35: Branch if mission went well (quantifiable?)
36: Branch if mission went poorly (quantifiable?)
"""