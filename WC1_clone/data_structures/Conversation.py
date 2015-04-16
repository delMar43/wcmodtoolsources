"""
This module defines the Conversation, ConversationScreen, and TalkingHeadScreen classes
"""

class ConversationScreen(InterfaceScreen):
	def __init__(self, static_images, animations, music, text_string, text_color, branch_conditions=()):
		InterfaceScreen.__init__(self, static_images, animations, music)
		
		self.text_string = text_string
		self.text_color = text_color
		self.branch_conditions = branch_conditions
		
	def EvalBranch(self):
		"""
		Evaluate all branch conditions associated with this screen
		If any are true, transition to their destination
		"""
		retval = None
		for bc in self.branch_conditions;
			if bc.Eval():
				retval = bc.Eval()
				
		return retval
		
	def DrawText(self):
		"""
		Draw the text_string in text_color
		Insert status variables as appropriate
		"""

class TalkingHeadScreen(ConversationScreen):
	def __init__(self, static_images, animations, music, exit_dest, text, text_color, mouth_string, face_string):
		sent_animations = list(animations)
		sent_animations.append(self.GenerateMouthAnimation(mouth_string)) #add the proper animation for the mouth motions of the talking head
		sent_animations.append(self.GenerateFaceAnimation(face_string)) #add the proper animation for the expressions of the talking head
		ConversationScreen.__init__(self, static_images, sent_animations, music, exit_dest, text, text_color)
		
	def GenerateMouthAnimation(self, mouth_string):
		##define mouth animation frames
		return animation
		
	def GenerateFaceAnimation(self, face_string):
		##define face animation frames
		return animation
		
class Conversation():
	"""
	Have a list of screens
	Draw screens w/ text
		Insert system variables into text
	Change from screen to screen
		Branch between screens as appropriate
	"""
	
	def __init__(self, screens=(), exit_dest):
	
		if isinstance(screens, (list, tuple)):
			self.screens = screens
		else:
			raise TypeError
			
		self.exit_dest = exit_dest
			
		self.present_screen_index = None
	
	def Play(self):
		self.present_screen_index = 0
		self.screens[self.present_screen_index].Enter()
	
	def Advance(self):
		self.present_screen_index += 1
		
		#evaluate branch conditions until no more true branches found
		retval = self.screens[self.present_screen_index].EvalBranch()
		while retval:
			self.present_screen_index = retval
			retval = self.screens[self.present_screen_index].EvalBranch()
		
		if self.present_screen_index < len(self.screens):
			self.screens[self.present_screen_index].Enter()
			self.screens[self.present_screen_index].DrawText()
			
		else:
			self.Stop()
	
	def Stop(self):
		self.present_screen_index = None
		##transition to the exit_dest