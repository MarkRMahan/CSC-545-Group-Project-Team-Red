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

class Ball():
    def __init__(self):
        self.w = int(random(10, 51))
        self.h = self.w
        self.xpos = 500
        self.ypos = 100
        self.canvasWidth = 1000
        self.canvasHeight = 600
        
        self.c = color(int(random(0, 360)), 100, 100)
        self.gravityValue = 1
        self.verticalSpeed = 0
        self.horizontalSpeed = 10
        self.airResistance = 0.0001
        self.friction = 0.1
            
    def display(self):
        fill(self.c)
        ellipse(self.xpos, self.ypos, self.w, self.h)
        
    def moveLeft(self):
        self.xpos -= 2
        
    def moveRight(self):
        self.xpos += 2
        
    def gravitationalPull(self):
        self.verticalSpeed += self.gravityValue #Vertical speed will increase/decrease
        self.ypos += self.verticalSpeed #Change where the ball is
        self.xpos += self.horizontalSpeed
        self.verticalSpeed -= (self.verticalSpeed * self.airResistance)
        self.horizontalSpeed -= (self.horizontalSpeed * self.airResistance)
        
    def bounceBottom(self):
        self.ypos = self.canvasHeight - (self.h / 2)
        self.verticalSpeed *= -1
        self.verticalSpeed -= (self.verticalSpeed * self.friction)
        
    def bounceTop(self):
        self.ypos = self.h / 2
        self.verticalSpeed *= -1
        self.verticalSpeed -= (self.verticalSpeed * self.friction)
        
    def bounceLeft(self):
        self.xpos = self.w / 2
        self.horizontalSpeed *= -1
        self.horizontalSpeed -= (self.horizontalSpeed * self.friction)
        
    def bounceRight(self):
        self.xpos = self.canvasWidth - (self.w / 2)
        self.horizontalSpeed *= -1
        self.horizontalSpeed -= (self.horizontalSpeed * self.friction)
        
    def inBounds(self):
        if self.ypos + (self.h / 2) > self.canvasHeight:
            self.bounceBottom()
        if self.ypos < 0:
            self.bounceTop()
        if self.xpos + (self.w / 2) > self.canvasWidth:
            self.bounceRight()
        if self.xpos < 0:
            self.bounceLeft()
        
#~~~~~~~~~~~~~~~~~~~~~~

screenType = 0
theBall = Ball()

#~~~~~~~~~~~~~~~~~~~~~~

def setup():
    size(1000, 600)
    
def draw():
    if screenType == 0:
        titleScreen()
    elif screenType == 1:
        gameScreen()
    elif screenType == 2:
        gameOverScreen()

#~~~~~~~~~~~~~~~~~~~~~~~

def titleScreen():
    background(0)
    textAlign(CENTER)
    text("Click to start", 500, 300)
    
def gameScreen():
    background(255)
    Ball.display(theBall)
    Ball.gravitationalPull(theBall)
    Ball.inBounds(theBall)
    
def gameOverScreen():
    pass
    
#~~~~~~~~~~~~~~~~~~~~~~~

def keyPressed():
    if key == CODED:
        if keyCode == LEFT:
            Ball.moveLeft(theBall)
        elif keyCode == RIGHT:
            Ball.moveRight(theBall)

def mousePressed():
    if screenType == 0:
        startGame()
        
#~~~~~~~~~~~~~~~~~~~~~~~

def startGame():
    global screenType
    screenType = 1