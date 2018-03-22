/*
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
*/

int screenType = 0;
Ball theBall = new Ball(); // The bouncing ball
Block testBlock = new Block(); // Test block for now

void setup() {
  size(1000, 600);
}

void draw() {
  if (screenType == 0) titleScreen();
  else if (screenType == 1) gameScreen();
  else if (screenType == 2) gameOverScreen();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void titleScreen() {
  background(0);
}

void gameScreen() {
  background(255);
  theBall.displayBall(); // Displays the ball
  testBlock.displayBlock(); // Displays the block
  testBlock.blockBounce(theBall, theBall.ballXpos, theBall.ballYpos); // Bounces the ball off of the block
  theBall.gravitationalPull(); // Gravity
  theBall.inBounds(); // Keeps the ball in-bounds
}

void gameOverScreen() {
  // Will be implemented later
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) theBall.moveLeft(); // Moves the ball left
    else if (keyCode == RIGHT) theBall.moveRight(); // Moves the ball right
  }
}

void mousePressed() {
  if (screenType == 0) startGame(); // A click will start the game
}

void startGame() {
  screenType = 1; // Changes the screen
}