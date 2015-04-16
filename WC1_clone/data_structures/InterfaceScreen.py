"""
This module defines the generic InterfaceScreen class, ScreenHotspot, and RoomScreen classes
"""

class InterfaceScreen:
	"""
	An interface screen has some collection of static background images and animations
	Rooms, the killboard, and conversation screens all inherit from this class
	"""
	def __init__(self, static_images=(), animations=(), music = None):
	
		if isinstance(static_images, (list, tuple)):
			self.static_images = static_images
		else:
			raise TypeError
			
		if isinstance(animations, (list, tuple)):
			self.animations = animations
		else:
			raise TypeError
			
		if isinstance(music, Music.Music):
			self.music = music
		else:
			self.music = Music.NoMusic
		
	def Enter(self):
		static_master.Register(self.static_images)
		
		for a in self.animations:
			a.Play()
		
		self.music.Play()
		
	def Exit(self):
		static_master.Deregister(self.static_images)
		
		for a in self.animations:
			a.Stop()
	
class ScreenHotspot:
	"""
	A hotspot is a clickable area of the screen, a rectangle defined by its upper-left corner, width, and length
	The hotspot has a destination, meaning whatever happens when it is clicked
	The hotspot also has a text description that is shown when the mouse hovers over it
	"""
	def __init__(self, (x,y), (width,length), dest, text):
		self.ul_coords = (x,y)
		self.width = width
		self.length = length
		self.dest = dest
		self.text = text
	
class RoomScreen(InterfaceScreen):
	"""
	A room is an interface screen that has clickable hotspots in it
	"""
	def __init__(self, static_images=(), animations=(), music = None, hotspots = []):
		InterfaceScreen.__init__(self, static_images, animations, music)
		self.hotspots = list(hotspots)
		
class KillBoard(InterfaceScreen):
	"""
	The killboard is an interface screen with text drawn on it
	The text is based on the pilots' ranks, names, mission counts, and kill counts
	"""
	def __init__(self):
		##killboard_image = WHATEVER
		InterfaceScreen.__init__(self, (killboard_image))
		
	def Enter(self):
		InterfaceScreen.Enter(self)
		##draw killscore information

class Closet(InterfaceScreen):
	"""
	The closet is a static scren with the pilot's uniform and info about the present mission
	"""
	def __init__(self):
		##closet_image = WHATEVER
		InterfaceScreen.__init__(self, (closet_image))
		
	def Enter(self):
		InterfaceScreen.Enter(self)
		##draw ribbons and medals information
		##write present campaign info
		
class Pinup(InterfaceScreen):
	"""
	The pinup is a static image
	"""
	def __init__(self):
		##pinup_image = WHATEVER
		InterfaceScreen.__init__(self, (pinup_image), animations=None, music=None)
		
	def Enter(self):
		InterfaceScreen.Enter(self)