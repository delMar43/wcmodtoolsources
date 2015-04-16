"""
This module defines the Music objects for different sections of the game
"""

import pygame

class Music(pygame.mixer.Sound):
	def play(self):
		pygame.mixer.Sound.play(loops = -1)