import win32api
import win32gui
import time
from ctypes import *
import ImageGrab


time.sleep(2)

window = win32gui.GetForegroundWindow()
rect = win32gui.GetWindowRect(window)

xcor, ycor = rect[0:2]

xr = range(rect[0]+20, rect[2]-20)
yr = range(rect[1]+60, rect[3]-20)

xsize = rect[2] - rect[0]
ysize = rect[3] - rect[1]

#xr = range(0, xsize)
#yr = range(0, ysize)

row = [0]*xsize
spots = [row]*ysize

##moving mouse pointer needs to move faster
##grabbing wrong pixel of screen, needs to grab pointer location?

for x in xr:
	for y in yr:
		#win32api.SetCursorPos((x,y))
		ev = windll.user32.mouse_event(1, 0, 1, 0, 0) #move mouse down one
		pos = windll.user32.GetCursorPos()
		img = ImageGrab.grab() #grab a screenshot
		pix = img.load() 
		color = img.getpixel(pos) #grab the color at the present pixel
		print color
	ev = windll.user32.mouse_event(1, 1, -ysize, 0, 0)#move the mouse to the top of the next column
	

	#if the pixel is some particular shade of blue, don't save it
	#if the pixel is not that shade of blue, save it

for s in spots:
	print s
	
	
"""
Box is 68-708 wide, 88-488 tall
"""