class Block extends Ball {
  float blockXpos, blockYpos, blockWidth, blockHeight;
  
  Block() {
    blockWidth = 80;
    blockHeight = 20;
    blockXpos = 400;
    blockYpos = 500;
  }
  
  void displayBlock() {
    fill(0);
    rectMode(CENTER);
    rect(blockXpos, blockYpos, blockWidth, blockHeight);
  }
  
  void blockBounce(Ball theBall, float ballXpos, float ballYpos) {
    // If the ball is above/below the paddle
    if ((ballXpos + (h / 2) > blockXpos - (blockWidth / 2) && (ballXpos - (h / 2) < blockXpos + (blockWidth / 2)))) {
      // If the ball is "touching" the block
      if (ballYpos + (h / 2) > blockYpos - (blockHeight / 2) && ballYpos + (h / 2) < blockYpos + (blockHeight / 2)) {
        theBall.noReductionBounce(blockYpos); // Bounce off of the block
      }
    }
  }
  
}