import soy
from time import *

sizemult = 4

scr = soy.Screen()
win = soy.Window(scr,"Test Window", size=(320*sizemult,240*sizemult))

sce = soy.scenes.Scene()

bodies = []

#make a list of objects in the current reference frame
objs = []

objs.append(1) #debug code

for o in objs:
	collsurf = soy.shapes.Sphere(4)#collision sphere
	mat = soy.materials.Material() ##change this to be some different material, transparent
	mat.shininess = 5
	#bodies.append(soy.bodies.Body(scene=sce, model=soy.models.Shape(material=mat), shape=collsurf))
	
	imagesurf = soy.shapes.Capsule(9, 4) #draw the image on this surface
	bodies.append(soy.bodies.Body(scene=sce, model=soy.models.Shape(material=mat), shape=imagesurf))

light = soy.bodies.Light(sce)
camera = soy.bodies.Camera(sce)
pro = soy.widgets.Projector(win,camera=camera)

##set camera position to match pilot position
camera.position = (0,0,85.0)
#light.position = (0.5, 1.0, 5.0)

bodies[0].rotation = (1,1,1) # Rotate the cube 1 unit in the X axis,1 unit in the Y axis and 1 unit in the Z axis

while True:
	pass