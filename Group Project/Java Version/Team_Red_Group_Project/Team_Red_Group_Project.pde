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
IDEA: SWITCH GRAVITY PERIODICALLY
*/

int screenType = 0;
Ball theBall = new Ball(); // The bouncing ball
int numBlocks = 5;
Block testBlocks[] = new Block[numBlocks]; // Test block for now

//this section is for music
import processing.sound.*;
SoundFile file;
//Important: audio files must be in mono
String audioName = "Art_Of_Escapism_-_Little_by_Little.mp3";
String path;
//

void setup() {
  size(1500, 600);
  for (int i = numBlocks - 1; i != -1; i--) {
    testBlocks[i] = new Block();
  }
  //music section
  path = sketchPath(audioName);
  file = new SoundFile(this,path);
  file.play();
  file.stop();
  file.loop();
}

void draw() {
  if (screenType == 0) titleScreen();
  else if (screenType == 1) gameScreen();
  else if (screenType == 2) gameOverScreen();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void titleScreen() {
  background(150);
}

void gameScreen() {
  background(255);
  theBall.displayBall(); // Displays the ball
  for (int i = 0; i < numBlocks; i++) {
    testBlocks[i].displayBlock();
    testBlocks[i].blockBounce(theBall, theBall.ballXpos, theBall.ballYpos);
  }
  //testBlock.displayBlock(); // Displays the block
  //testBlock.blockBounce(theBall, theBall.ballXpos, theBall.ballYpos); // Bounces the ball off of the block
  theBall.gravitationalPull(); // Gravity
  theBall.inBounds(); // Keeps the ball in-bounds
}

void gameOverScreen() {
  // Will be implemented later
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void mousePressed() {
  if (screenType == 0) screenType = 1; // A click will start the game
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) theBall.moveLeft(); // Moves the ball left
    else if (keyCode == RIGHT) theBall.moveRight(); // Moves the ball right
    else if (keyCode == UP || keyCode == DOWN) theBall.switchGravity();
  }
}