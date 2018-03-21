class Ball {
  float airResistance, friction, w, h, ballXpos, ballYpos, canvasWidth, canvasHeight, gravityValue, vertSpeed, horizSpeed; // xpos and ypos used to track ball
  color c;
  String direction; 
  
  Ball() {
    // Random color ball each time
    c = color(int(random(0, 360)), 100, 100);
    
    // Width and height of the ball
    w = 25;
    h = w;
    
    // The ball's x and y positions
    ballXpos = 500;
    ballYpos = 100;
    
    canvasWidth = 1000;
    canvasHeight = 600;
    direction = "East"; // Ball starts out moving "East"
    
    // Used for the "physics" of the ball
    gravityValue = 1;
    vertSpeed = 0;
    horizSpeed = 10;
    airResistance = 0.0001;
    friction = 0.1;
  }
  
  void displayBall() { // Displays the ball
    fill(c);
    ellipse(ballXpos, ballYpos, w, h);
  }
  
  void moveLeft() {
    if (direction == "East") {
      horizSpeed *= -1;
      direction = "West";
    }
  }
  
  void moveRight() {
    if (direction == "West") {
      horizSpeed *= -1;
      direction = "East";
    }
  }
  
  void gravitationalPull() {
    vertSpeed += gravityValue; // Vertical speed will increase/decrease
    ballYpos += vertSpeed; // Change where the ball is vertically
    ballXpos += horizSpeed; // Change where the ball is horizontally
    vertSpeed -= (vertSpeed * airResistance);
    horizSpeed -= (horizSpeed * airResistance);
  }
  
  void bounceBottom(float surface) { // Bounces off the bottom of the canvas
    ballYpos = surface - (h / 2);
    vertSpeed *= -1;
    vertSpeed -= (vertSpeed * friction); // Slows the ball down with friction
    //horizSpeed -= (horizSpeed * friction);
  }
  
  void noReductionBounce(float surface) { // Used for the block(s)
    ballYpos = surface - (h / 2);
    vertSpeed *= -1;
    vertSpeed += (vertSpeed * friction);
  }
  
  void bounceTop() { // Bounces off of the top
    ballYpos = (h / 2);
    vertSpeed *= -1;
    vertSpeed -= (vertSpeed * friction); // Slows the ball down with friction
  }
  
  void bounceLeft() { // Bounces off of the left wall
    ballXpos = (w / 2);
    horizSpeed *= -1;
    horizSpeed -= (horizSpeed * friction); // Slows the ball down with friction
    direction = "East";
  }
  
  void bounceRight() { // Bounces off of the right wall
    ballXpos = canvasWidth - (w / 2);
    horizSpeed *= -1;
    horizSpeed -= (horizSpeed * friction); // Slows the ball down with friction
    direction = "West";
  }
  
  void inBounds() { // Keeps the ball in-bounds
    if (ballYpos + (h / 2) > canvasHeight) bounceBottom(canvasHeight);
    if (ballYpos < 0) bounceTop();
    if (ballXpos + (w / 2) > canvasWidth) bounceRight();
    if (ballXpos < 0) bounceLeft();
  }
  
}