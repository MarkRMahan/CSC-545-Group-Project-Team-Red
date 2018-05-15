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
 Download the minim library in order to play
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 */

Minim minim;
AudioPlayer player;
PFont font;

Ball theBall = new Ball(); // The bouncing ball
int numBlocks = 5;
Block blackBlocks[] = new Block[numBlocks]; // Black blocks
redBlock redBlocks[] = new redBlock[numBlocks];  //Red blocks
dangerZone danger_zones = new dangerZone(); // Danger zones
int score, life, time, listScore;
int i = 0, counter = 0, j = 0, screenType = 0;
String a, b, c;
String[] initials = new String[1];
String[] linesHS;
String[]letters ={"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
String[] musicFiles = {"Dragonforce-ThroughTheFireAndTheFlames.mp3", "FFX-SeymourBattle.mp3", "PushItToTheLimit.mp3"};
int songNum = musicFiles.length - 1; // Last song in the list is set to the default song

void setup() {
  size(1500, 600);
  linesHS = loadStrings("highscores.txt");
  minim = new Minim(this);
  player = minim.loadFile(musicFiles[songNum]);  //Song player
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
  for (int i = 0; i < numBlocks; i++) { // Displays the red and black blocks
    blackBlocks[i].displayBlock();
    blackBlocks[i].blockBounce(theBall, theBall.ballXpos, theBall.ballYpos);
    redBlocks[i].displayBlock();
    redBlocks[i].blockBounce(theBall, theBall.ballXpos, theBall.ballYpos);
  }
  theBall.gravitationalPull(); // Gravity
  theBall.inBounds(); // Keeps the ball in-bounds
  theBall.speedLimit(); // Keeps the game playable lol
  danger_zones.turn_zone_on(); // Randomly turns the zone on
  danger_zones.flashZoneTop(); // Warning flash for the top zone
  danger_zones.flashZoneBottom(); // Warning flash for the bottom zone
  danger_zones.displayTopDangerZone(); // Displays the top danger zone
  danger_zones.displayBottomDangerZone(); // Displays the bottom danger zone

}

void scoreLife() { // Shows the current score and life
  noFill();
  rectMode(CORNERS);
  rect(10, 30, 160, 100);
  textSize(20);
  fill(0);
  text("POINTS: " + score, 80, 50);
  text("LIFE: " + life, 65, 75);
  
}

void gameOverScreen() { // Game over screen
  clear();
  fill(255);
  textSize(60);
  text("Press R to RESTART", width/2, height*11/12-75);
  float m = millis();
  fill(m % 255);
  textSize(100);
  text("GAME OVER", width/2, height/2-175);
  textSize(30);
  fill(255);
  text("HIGH SCORE", width*4/7+50, height*3/5-75);
  String[]splitLines = split(linesHS[0], ':');
  listScore = parseInt(splitLines[1]); 
  gameOverScoreText();
  
  if (score > listScore) { // Check if there is a new high score
    text("NEW HIGH SCORE: " +score, width*3/7-50, height*3/5-75);
    text(a, width*3/7-90, height*3/5-25);
    text(b, width*3/7-50, height*3/5-25);
    text(c, width*3/7-10, height*3/5-25);
  } else { // No new high score
    text("YOUR SCORE ", width*3/7-50, height*3/5-75);
    text(score, width*3/7-50, height*3/5-25);
  }
  text(linesHS[0], width*4/7+50, height*3/5-25);
}

void gameOverScoreText() {
  if (counter <= 0) {
    a = letters[i];
  }
  if (counter <= 1) {
    b = letters[i];
  }
  if (counter <= 2) {
    c = letters[i];
  }
  if (counter == 3) {
    if (score>listScore) {
      initials[j] = a+""+b+""+c+" "+"Score:"+score;
      saveStrings("highscores.txt", initials);
      linesHS[0] =initials[j];
    }
  }
}

void changeSong(int num) { // Used for changing the songs
  player.pause();
  songNum = num;
  player = minim.loadFile(musicFiles[songNum]);
  player.loop();
}

void keyPressed() {
  if (key == '1') changeSong(0);
  if (key == '2') changeSong(1);
  if (key == '3') changeSong(2);
  if (screenType !=2) {
    if (key == CODED) {
      if (keyCode == LEFT) theBall.moveLeft(); // Moves the ball left
      else if (keyCode == RIGHT) theBall.moveRight(); // Moves the ball right
      else if (keyCode == UP || keyCode == DOWN) theBall.switchGravity();
    }
    if (key == 's' && screenType == 0) { // Start the game
      screenType = 1;
      player.loop();  //Play music when the game starts
    }
    if (key == 'r') {  //Reset button(r)
      score=0;
      life = 5;
      makeBlocks();
      theBall = new Ball();
      danger_zones = new dangerZone();
      screenType = 1;  //Go back to the game screen
    }
  } else if (screenType == 2) {
    if (key == CODED) {
      if (keyCode == UP) {
        if (i>=letters.length-1) {
          i = letters.length-1;
        } else {
          i++;
        }
      } else if (keyCode == DOWN) {
        if (i <= 0) {
          i = 0;
        } else {
          i--;
        }
      }
    } else if (key == ENTER) {
      counter++;
    } else if (key == 'r') {  //Reset button(r)
      score=0;
      life = 5;
      counter = 0;
      i=0;
      makeBlocks();
      theBall = new Ball();
      danger_zones = new dangerZone();
      screenType = 1;//Go back to first screen
    }
  }
}