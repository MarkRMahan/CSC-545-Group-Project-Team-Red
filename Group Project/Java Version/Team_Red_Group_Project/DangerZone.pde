class dangerZone extends redBlock{
  boolean dangerTop, dangerBottom, flashingTop, flashingBottom, outsideTop, outsideBottom;
  float topSeconds, bottomSeconds;
  color zone_color;
  
  dangerZone() {
    zone_color = color(255, 0, 0);
    dangerTop = false;
    dangerBottom = false;
    flashingTop = false;
    flashingBottom = false;
    outsideTop = true;
    outsideBottom = true;
    topSeconds = 0;
    bottomSeconds = 0;
  }
  
  void displayTopDangerZone() {
    if (dangerTop) {
      fill(zone_color, 191);
      rect(width/2, 0, width, 30);
      if (theBall.ballYpos <= 30 && outsideTop) {
        life --;
        outsideTop = false;
      } 
      if (theBall.ballYpos > 30) {
        outsideTop = true;
      }
      
      topSeconds += 1;
      if (topSeconds >= 300) {
        dangerTop = false;
        noFill();
        topSeconds = 0;
      }
      
    }
  }
   
  void displayBottomDangerZone() {
    if (dangerBottom) {
      fill(zone_color, 191);
      rect(width/2, height, width, 30);
      if (theBall.ballYpos >= height - 30 && outsideBottom) {
        life --;
        outsideBottom = false;
      }
      if (theBall.ballYpos < height - 30) {
        outsideBottom = true;
      }
      
      bottomSeconds += 1;
      if (bottomSeconds >= 300) {
        dangerBottom = false;
        noFill();
        bottomSeconds = 0;
      }
      
    }
    if (life <= 0) screenType = 2;
  }
  
  void touchZone() {
    
  }
  
  void flashZoneTop() {
    if (flashingTop) {
      topSeconds += 1;
      fill(millis() % 255, 0, 0);
      rect(width/2, 0, width, 30);
      if (topSeconds >= 180) {
        dangerTop = true;
        flashingTop = false;
        topSeconds = 0;
      }
    }
  }
  
  void flashZoneBottom() {
    if (flashingBottom) {
      bottomSeconds += 1;
      fill(millis() % 255, 0, 0);
      rect(width/2, height, width, 30);
      //println("here");
      if (bottomSeconds >= 180) {
        dangerBottom = true;
        flashingBottom = false;
        bottomSeconds = 0;
      }
    }
  }
  
  void turn_zone_on() {
    float r = random(1000);
    if (r <= 1.0 && flashingTop == false) {
      flashingTop = true;
    }
    r = random(1000);
    if (r >= 999.0 && flashingBottom == false) {
      flashingBottom = true;
    }
  }
  
}
