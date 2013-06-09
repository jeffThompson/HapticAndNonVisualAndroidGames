
void drawTitleScreen() {
  
  // flaring center light
  /*background(0);
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      float dist = abs(dist(x,y, w/2,h/2));
      fill(map(dist, 0,h/2, 255,0));
      rect(x*mapGridSize, y*mapGridSize, mapGridSize,mapGridSize);
    }
  }*/ 
  
  // Perlin noise (dimmed for easier text)
  background(0);
  float yOffset = 0.0;
  for (int y=0; y<h; y++) {
    yOffset += noiseInc;
    float xOffset = 0.0;
    for (int x=0; x<w+5; x++) {
      fill(noise(xOffset, yOffset) * 100);
      rect(x*(width/w), y*(height/h), width/w, height/h);
      xOffset += noiseInc;
    }
  }
  
  // fade up from bottom
  strokeWeight(3);
  for (int y=0; y<150; y++) {
    stroke(0, map(y, 0,150, 255,0));
    line(0,height-y, width,height-y);
  }
  strokeWeight(1);
  
  // main title
  noStroke();
  fill(255);
  textFont(titleFont);
  text("CAVE", width/2, height/3 + 100);
  
  // details and instructions
  fill(255);
  textFont(directionFont);
  String details = "Jeff Thompson   |   2013   |   www.jeffreythompson.org";
  details += "\n\n";
  details += "[   swipe up, right, down, left to navigate the cave   ]";
  text(details, width/2,height-height/3);
}
