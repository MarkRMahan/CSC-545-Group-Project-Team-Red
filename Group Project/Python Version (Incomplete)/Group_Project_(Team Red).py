'''
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Group Project: Team Red
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Authors:
    Mark R. Mahan
    Joshua Yamdogo
    Samuel Trenter
    Shinya Honda
    Humberto Colin
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This project is meant to run a platforming game
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'''

from tkinter import *

class Platformer(Frame):
    
    def __init__(self):
        Frame.__init__(self)
        self.master.title("Platformer") #Frame's title
        self.grid()
        
        self.height = 600
        self.width = 1000
        self.canvas = Canvas(self, height = 600, width = 1000, bg = "white")
        self.canvas.grid(row = 1, column = 0)
        
        self.Game() #Runs the "game"
        
    def Game(self):
        print("hello world")
        
        
def main():
    Platformer().mainloop()
