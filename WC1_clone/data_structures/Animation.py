"""
This module defines the AnimationFrame and Animation classes
"""

class AnimationFrame(GameImage):
	"""
	This is a single frame of animation
	A frame is an image at a location
	"""
	def __init__(self, data, (x,y)):
		"""
		This extends the init function of an image by also storing the coordinates of the frame
		"""
		GameImage.__init__(self, data)
		self.coords = (x,y)
		
	def Draw(self):
		"""
		Draw this animation frame at its coordinates
		"""
		GameImage.Draw(self, self.coords)
		
class Animation:
	"""
	This is an entire animation
	An animation is a list of AnimationFrames, plus the index of the current frame, and a flag for whether the animation loops
	"""
	
	def __init__(self, frames=[], loop = 0):
		"""
		Accept a list of frames
		Initialize the present_frame to None, indicating that the animation is not running
		"""
		
		if isinstance(frames, (list, tuple)):
			self.frames = frames
		else:
			raise TypeError
			
		if not loop:
			self.loop = 0
		else:
			self.loop = 1
			
		self.present_frame = None
		
	def Play(self):
		"""
		Begin playing this animation
		"""
		self.present_frame = 0
		
		self.frames[self.present_frame].Draw()
		
		animation_master.Register(self)
		
	def Advance(self):
		"""
		Draw the next frame of this animation, if any
		Loop after last frame if flagged to loop
		End after last frame if not flagged to loop
		"""
		
		self.present_frame += 1
		
		if self.present_frame < len(self.frames):
			self.frames[self.present_frame].Draw()
			
		else if self.loop:
			self.present_frame = 0
			self.frames[self.present_frame].Draw()
		
		else:
			self.Stop()
		
	def Stop(self):
		self.present_frame = None
		
		animation_master.Deregister(self)