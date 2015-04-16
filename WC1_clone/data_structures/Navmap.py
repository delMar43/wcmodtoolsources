class NavmapIcon:
	def __init__(self, label, icon, coords = (x,y,z), visible = 1):
		self.label = label
		self.icon = icon
		self.coords = (x,y,z)
		self.visible = visible
		
class GreenSquareNavmapIcon(NavmapIcon):
	def __init__(self, label, visible = 1):
		NavmapIcon.__init__(self, label, green_square_nav_icon, visible)

class WhiteTriangleNavmapIcon(NavmapIcon):
	def __init__(self, label, visible = 1):
		NavmapIcon.__init__(self, label, green_square_nav_icon, visible)

class PurpleCrossNavmapIcon(NavmapIcon):
	def __init__(self, label, visible = 1):
		NavmapIcon.__init__(self, label, purple_cross_nav_icon, visible)

class GreenCircleNavmapIcon(NavmapIcon):
	def __init__(self, label, visible = 1):
		NavmapIcon.__init__(self, label, green_circle_nav_icon, visible)

class RedCircleNavmapIcon(NavmapIcon):
	def __init__(self, label, visible = 1):
		NavmapIcon.__init__(self, label, red_circle_nav_icon, visible)

class Navmap:
	def __init__(self, icons = ()):
		self.icons = icons