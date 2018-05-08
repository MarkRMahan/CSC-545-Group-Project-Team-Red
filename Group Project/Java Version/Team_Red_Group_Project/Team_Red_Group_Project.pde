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
Block blackBlocks[] = new Block[numBlocks]; // Test block for now
redBlock redBlocks[] = new redBlock[numBlocks];  //red blocks
dangerZone danger_zones = new dangerZone();
int score;
int life;
int time;

void setup() {
  size(1500, 600);
  minim = new Minim(this);
  player = minim.loadFile("aaa.mp3");  //sample music from my file
  makeBlocks();
  score = 0;
  life = 5;
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
  rect(width/2-315, height-290, 280, 35);
  rect(width/2+35, height-290, 280, 35);

  textSize(35);
  fill(255, 0, 0);
  text("TEAM RED", width-85, height-20);
  fill(0);
  text("Press S to START", width/2-175, height-275);
  text("Press R to RESET", width/2+175, height-275);
}

void makeBlocks() {
  for (int i = numBlocks - 1; i != -1; i--) {
    blackBlocks[i] = new Block();
  }
  for (int i = numBlocks - 1; i != -1; i--) {
    redBlocks[i] = new redBlock();
  }
}

void gameScreen() {
  background(255);
  scoreLife();
  theBall.displayBall(); // Displays the ball
  for (int i = 0; i < numBlocks; i++) {
    blackBlocks[i].displayBlock();
    blackBlocks[i].blockBounce(theBall, theBall.ballXpos, theBall.ballYpos);
    redBlocks[i].displayBlock();
    redBlocks[i].blockBounce(theBall, theBall.ballXpos, theBall.ballYpos);
  }
  theBall.gravitationalPull(); // Gravity
  theBall.inBounds(); // Keeps the ball in-bounds
  theBall.speedLimit();
  danger_zones.turn_zone_on();
  danger_zones.flashZoneTop();
  danger_zones.flashZoneBottom();
  danger_zones.displayTopDangerZone();
  danger_zones.displayBottomDangerZone();
  
  //println(theBall.vertSpeed);
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
    makeBlocks();
    theBall = new Ball();
    danger_zones = new dangerZone();
    screenType = 1;  //Go back to play screen
  }
}