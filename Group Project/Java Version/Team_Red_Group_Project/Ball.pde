class Ball {
  float airResistance, friction, w, h, ballXpos, ballYpos, ballDX, ballDY, targetX, targetY, canvasWidth, canvasHeight, gravityValue, vertSpeed, horizSpeed, easing;
  color c;
  String sidewaysDirection;
  
  Ball() {
    // Random color ball each time
    c = color(255);
    
    // Width and height of the ball
    w = 25;
    h = w;
    
    // The ball's x and y positions
    targetX = 500;
    targetY = 100;
     
    // Used to "smooth" the ball animation a bit
    ballDX = targetX - ballXpos;
    ballDY = targetY - ballYpos;
    ballXpos = ballDX * easing;
    ballYpos = ballDY * easing;
    
    canvasWidth = 1500;
    canvasHeight = 600;
    sidewaysDirection = "East"; // Ball starts out moving "East"
    
    // Used for the "physics" of the ball
    gravityValue = 1.5;
    vertSpeed = 0;
    horizSpeed = 30;
    airResistance = 0.0001;
    friction = 0.1;
    easing = 0.15;
  }
  
  void displayBall() { // Displays the ball
    fill(c);
    ellipse(ballXpos, ballYpos, w, h);
  }
  
  void moveLeft() {
    if (sidewaysDirection == "East") {
      horizSpeed *= -1;
      sidewaysDirection = "West";
    }
  }
  
  void moveRight() {
    if (sidewaysDirection == "West") {
      horizSpeed *= -1;
      sidewaysDirection = "East";
    }
  }
  
  void gravitationalPull() {
    vertSpeed += gravityValue; // Vertical speed will increase/decrease
    targetY = ballYpos + vertSpeed; // Change where the ball is vertically
    targetX = ballXpos + horizSpeed; // Change where the ball is horizontally
    ballDX = targetX - ballXpos; // Used for "easing" the ball
    ballDY = targetY - ballYpos;
    ballXpos += ballDX * easing; // Ease the ball (Make it look smoother)
    ballYpos += ballDY * easing;
    vertSpeed -= (vertSpeed * airResistance);
    //horizSpeed -= (horizSpeed * airResistance);
  }
  
  void switchGravity() {
    gravityValue *= -1;
  }
  
  void noReductionBounce(float surface) { // Used for the block(s)
    if (gravityValue > 0) {
      ballYpos = surface - (h / 2);
    } else {
      ballYpos = surface + (h + 2);
    }
    vertSpeed *= -1;
    //vertSpeed += (vertSpeed * friction) * 1.01;
  }
  
  void bounceBottom(float surface) { // Bounces off the bottom of the canvas
    ballYpos = surface - (h / 2);
    vertSpeed *= -1;
    vertSpeed -= (vertSpeed * friction); // Slows the ball down with friction
  }

  void bounceTop(float surface) { // Bounces off of the top
    ballYpos = surface + (h / 2);
    vertSpeed *= -1;
    vertSpeed -= (vertSpeed * friction); // Slows the ball down with friction
  }

  void bounceLeft() { // Bounces off of the left wall
    ballXpos = (w / 2);
    horizSpeed *= -1;
    sidewaysDirection = "East";
  }
  
  void bounceRight() { // Bounces off of the right wall
    ballXpos = canvasWidth - (w / 2);
    horizSpeed *= -1;
    //horizSpeed -= (horizSpeed * friction); // Slows the ball down with friction
    sidewaysDirection = "West";
  }
  
  void topIndicator() { // Indicates gravity is pulling the ball up
    fill(150, 0, 250);
    c = color(150, 0, 250);
    triangle(canvasWidth/2, 30, canvasWidth/2 - w / 2, h + 30, canvasWidth/2 + w / 2, h + 30);

  }
  
  void bottomIndicator() { // Gravity is normal
    fill(0, 0, 255);
    c = color(0, 0, 255);
    triangle(canvasWidth/2, canvasHeight - 30, canvasWidth/2 + w / 2, canvasHeight - h - 30, 
    canvasWidth/2 - w / 2, canvasHeight - h - 30);

  }
  
  void speedLimit() { // Limits the max speed of the ball
    if (vertSpeed > 75) vertSpeed = 75;
    if (vertSpeed < -75) vertSpeed = -75;
  }
  
  void inBounds() { // Keeps the ball in-bounds
    if (gravityValue > 0) {
      bottomIndicator();
      if (ballYpos < 0) bounceTop(0);
      if (ballYpos + (h / 2) > canvasHeight) bounceBottom(canvasHeight);
    } else {
      topIndicator();
      if (ballYpos > canvasHeight) bounceBottom(canvasHeight);
      if (ballYpos + (h / 2) < 0) bounceTop(0);
    }
    if (ballXpos + (w / 2) > canvasWidth) bounceRight();
    if (ballXpos < 0) bounceLeft();
  }
}