
void drawSky() {
  
  background(134,153,255);
  
  // sky (change color based on time of day)
  
  // sunrise
  if (hour() == sunrise) {
    if (minute() < 30) {
      float r = map(minute(), 0, 29, 6, 188);
      float g = map(minute(), 0, 29, 15, 153);
      float b = map(minute(), 0, 29, 64, 27);
      background(r, g, b);
    }
    else {
      float r = map(minute(), 30, 59, 188, 134);
      float g = map(minute(), 30, 59, 153, 153);
      float b = map(minute(), 30, 59, 27, 255);
      background(r, g, b);
    }
  }
  
  // sunset
  else if (hour() == sunset) {
    if (minute() < 30) {
      float r = map(minute(), 0, 29, 134, 188);
      float g = map(minute(), 0, 29, 153, 153);
      float b = map(minute(), 0, 29, 255, 27);
      background(r, g, b);
    }
    else {
      float r = map(minute(), 30, 59, 188, 6);
      float g = map(minute(), 30, 59, 153, 15);
      float b = map(minute(), 30, 59, 27, 64);
      background(r, g, b);      
    }
  }
  
  // nighttime
  else if (hour() < sunrise || hour() > sunset) {
    background(6,15,64);
  }
  
  // rest of day
  else {
    background(134,153,255);
  }
}
