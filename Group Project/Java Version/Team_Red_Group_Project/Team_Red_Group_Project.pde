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
PFont font;

int screenType = 0;
Ball theBall = new Ball(); // The bouncing ball
int numBlocks = 5;
Block testBlocks[] = new Block[numBlocks]; // Test block for now
redBlock test_rBlocks[] = new redBlock[numBlocks];  //red blocks
int score;
int life;
int time;

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
  
  score = 0;
  life = 0;
}

void draw() {
  if (screenType == 0) startScreen();
  else if (screenType == 1) gameScreen();
  else if (screenType == 2) gameOverScreen();
}

void startScreen() {
  clear();
  background(255);
  //println("Width is: " + width);
  //println("Height is: " + height);
  font = createFont("Britannic Bold", 32);
  textFont(font);
  textAlign(CENTER, CENTER);

  textSize(60);
  fill(0);
  text("BRICK BOUNCE", width/2, height/2-100);

  fill(255);
  strokeWeight(2);
  println(height-290);
  rect(width/2-315, height-290, 280, 35);
  rect(width/2+35, height-290, 280, 35);

  textSize(35);
  fill(255, 0, 0);
  text("TEAM RED", width-85, height-20);
  fill(0);
  text("Press S to START", width/2-175, height-275);
  text("Press R to RESET", width/2+175, height-275);
}

void gameScreen() {
  background(255);
  scoreLife();
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
  theBall.speedLimit();
  println(theBall.vertSpeed);
}

void scoreLife() {
  textSize(20);
  fill(0);
  text("POINTS: " + score, 50, 10);
  text("LIFE: " + life, 35, 35);
}

void gameOverScreen() {
  clear();
  fill(255);
  textSize(60);
  text("Press R to RESTART", width/2, height/2+100);
  float m = millis();
  fill(m % 255);
  textSize(100);
  text("GAME OVER", width/2, height/2-100);
}

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
    score = 0;
    life = 5;
    screenType = 1;  //Go back to play screen
  }
}