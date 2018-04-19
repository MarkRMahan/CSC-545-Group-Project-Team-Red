class redBlock extends Ball {
  float blockXpos, blockYpos, blockWidth, blockHeight, canvasWidth, canvasHeight;
  
  redBlock() {
    blockWidth = 80;
    blockHeight = 20;
    canvasWidth = 1500;
    canvasHeight = 600;
    blockXpos = random(canvasWidth, canvasWidth + canvasWidth / 2);
    blockYpos = random(canvasHeight / 2, canvasHeight - 30);
  }
  
  void displayBlock() {
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(blockXpos, blockYpos, blockWidth, blockHeight);
    scrollBlock();
  }
  
  void scrollBlock() {
    blockXpos -= 5;
    if (blockXpos < 0 - 100) {
      blockXpos += canvasWidth + random(blockWidth, canvasWidth / 2);
      blockYpos = random(60, canvasHeight - 60);
    }
  }
  
  void blockBounce(Ball theBall, float ballXpos, float ballYpos) {
    // If the ball is above/below the paddle
    if ((ballXpos + (h / 2) > blockXpos - (blockWidth / 2) && (ballXpos - (h / 2) < blockXpos + (blockWidth / 2)))) {
      // If the ball is "touching" the block
      if (ballYpos > blockYpos - (blockHeight / 2) && ballYpos < blockYpos + (blockHeight / 2)) {
        theBall.noReductionBounce(blockYpos); // Bounce off of the block
      }
    }
  }
}
