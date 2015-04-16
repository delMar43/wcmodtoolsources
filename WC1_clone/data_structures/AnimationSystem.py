class StaticImageSystem:
	def __init__(self):
		self.statics = []
		
	def Tick(self):
		for i in self.statics:
			i.Draw()
			
	def Register(self, imgs = []):
		for img in imgs:
			if img not in self.statics:
				self.statics.append(img)
			
	def Deegister(self, imgs = []):
		for img in imgs:
			self.statics.remove(img)

class AnimationSystem:
	def __init__(self):
		self.animations = []
	
	def Tick(self):
		for a in self.animations:
			a.Advance()
			
	def Register(self, ani):
		if ani not in self.animations:
			self.animations.append(ani)
			
	def Deegister(self, ani):
		self.animations.remove(ani)
		
