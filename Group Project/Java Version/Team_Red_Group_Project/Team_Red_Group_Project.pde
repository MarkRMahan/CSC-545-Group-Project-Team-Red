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

Ball theBall = new Ball(); // The bouncing ball
int numBlocks = 5;
Block blackBlocks[] = new Block[numBlocks]; // Test block for now
redBlock redBlocks[] = new redBlock[numBlocks];  //red blocks
dangerZone danger_zones = new dangerZone();
int score, life, time, listScore;
int i = 0, counter = 0, j = 0, screenType = 0;
String a, b ,c;
String[] initials = new String[1];
String[] linesHS;
String[]letters ={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};

void setup() {
  size(1500, 600);
  linesHS = loadStrings("highscores.txt");
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
  text("Press R to RESTART", width/2, height*11/12-75);
  float m = millis();
  fill(m % 255);
  textSize(100);
  text("GAME OVER", width/2, height/2-175);
  textSize(30);
  fill(255);
  text("HIGH SCORE", width*4/7+50, height*3/5-75);
  //text("YOUR SCORE: " +score, width*3/7-50, height*3/5-75);
  String[]splitLines = split(linesHS[0],':');
  listScore = parseInt(splitLines[1]); 
  gameOverScoreText();
  //print("listScore: ", listScore);
  //print("score: ", score);
  if (score > listScore) {
    text("NEW HIGH SCORE: " +score, width*3/7-50, height*3/5-75);
    text(a,width*3/7-90,height*3/5-25);
    text(b,width*3/7-50,height*3/5-25);
    text(c,width*3/7-10,height*3/5-25);
  } else {
    text("YOUR SCORE: ", width*3/7-50, height*3/5-75);
    text(score, width*3/7-50, height*3/5-25);
  }
  text(linesHS[0],width*4/7+50,height*3/5-25);
}
void gameOverScoreText(){
  if(counter <= 0){
  //println(check1);
  
  a = letters[i];
  }
  if(counter <= 1){
    b = letters[i];
  }
  if(counter <= 2){
    c = letters[i];
  }
  if(counter == 3){
      //String[]splitLines = split(linesHS[0],':');
      //listScore = parseInt(splitLines[1]); 
      if(score>listScore){
        initials[j] = a+""+b+""+c+" "+"Score:"+score;
        saveStrings("highscores.txt",initials);
        linesHS[0] =initials[j];
      }
  }
}

void keyPressed() {
  if(screenType !=2){
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
      score=0;
      life = 5;
      makeBlocks();
      theBall = new Ball();
      danger_zones = new dangerZone();
      screenType = 1;  //Go back to first screen
    }
  }
  else if(screenType == 2){
    if(key == CODED){
      if(keyCode == UP){
        if(i>=letters.length-1){
          i = letters.length-1;
        }else{
          i++;
        }
      }else if(keyCode == DOWN){
        if(i <= 0){
          i = 0;
        }else{
          i--;
        }
      }
    }else if(key == ENTER){
        counter++;
      }else if (key == 'r') {  //Reset button(r)
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