import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

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

Minim minim;
AudioPlayer player;

int screenType = 0;
Ball theBall = new Ball(); // The bouncing ball
int numBlocks = 5;
Block testBlocks[] = new Block[numBlocks]; // Test block for now
redBlock test_rBlocks[] = new redBlock[numBlocks];  //red blocks

void setup() {
  size(1500, 600);
  for (int i = numBlocks - 1; i != -1; i--) {
    testBlocks[i] = new Block();
  }
  for (int i = numBlocks - 1; i != -1; i--) {
    test_rBlocks[i] = new redBlock();
  }
  minim = new Minim(this);
  player = minim.loadFile("aaa.mp3");  //sample music from my file
}

void draw() {
  if (screenType == 0) startScreen();
  else if (screenType == 1) gameScreen();
  else if (screenType == 2) gameOverScreen();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void startScreen() {
  background(150);
  text("Press S to start!", 100, 100);
  text("Press R to reset!", 100, 150);
}

void gameScreen() {
  background(255);
  theBall.displayBall(); // Displays the ball
  for (int i = 0; i < numBlocks; i++) {
    testBlocks[i].displayBlock();
    testBlocks[i].blockBounce(theBall, theBall.ballXpos, theBall.ballYpos);
    test_rBlocks[i].displayBlock();
    test_rBlocks[i].blockBounce(theBall, theBall.ballXpos, theBall.ballYpos);
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

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) theBall.moveLeft(); // Moves the ball left
    else if (keyCode == RIGHT) theBall.moveRight(); // Moves the ball right
    else if (keyCode == UP || keyCode == DOWN) theBall.switchGravity();
  }
  if (key == 's' && screenType == 0) {
    screenType = 1;
    player.play();  //Play music when start game
  }
  if (key == 'r') {  //Reset button(r)
    screenType = 0;  //Go back to first screen
  }
}
