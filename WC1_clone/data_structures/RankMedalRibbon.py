"""
This module defines the Rank, Medal, and Ribbon classes
"""

class Decoration:
	def __init__(self, name, image):
		if isinstance(name, (str, unicode)):
			self.name = name
		else:
			raise TypeError
			
		if isinstance(image, GameImage.GameImage):
			self.image = image
		else:
			raise TypeError

class Medal(Decoration)

class Ribbon(Decoration)

class Rank(Decoration):
	"""
	Each rank has a fullname (First Lieutennant), a shortname (Lieutennant), an abbreviation (1st LT.), and an image of the rank insignia
	"""
	def __init__(self, fullname, insignia, shortname, abbrev):
		"""
		Initialize a rank by defining its names and insignia image
		"""
	
		if isinstance(name, (str, unicode)):
			self.name = name
		else:
			raise TypeError
		
		if isinstance(insignia, GameImage.GameImage):
			self.insignia = insignia
		else:
			raise TypeError
		
		if isinstance(shortname, (str, unicode)):
			self.shortname = shortname
		else:
			raise TypeError
			
		if isinstance(abbrev, (str, unicode)):
			self.abbrev = abbrev
		else:
			raise TypeError
			
		