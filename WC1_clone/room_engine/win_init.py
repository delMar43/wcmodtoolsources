import os, pygame

#create window of correct size (320x200, with some multiple)
x = 320
y = 200
size_mult = 4
bright_mult = 4

pygame.init()
os.environ['SDL_VIDEO_WINDOW_POS'] = str(0) + "," + str(40) #put window in consistent location
os.environ['SDL_VIDEO_WINDOW_POS'] = str(0) + "," + str(40) #put window in consistent location

screen = pygame.display.set_mode((x*size_mult, y*size_mult))
screen2 = pygame.Surface((x,y))