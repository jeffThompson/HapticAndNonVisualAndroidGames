
void drawMapAndPlayer(boolean fullscreen) {

  if (fullscreen) {
    noSmooth();
    image(levelImage, 0, 0, width,height-250);    // show fullscreen (-some pixels for compass)
    
    noStroke();
    fill(255,150,0, 200);
    smooth();
    float px = map(playerX, 0, w, 0, width);
    float py = map(playerY, 0, h, 0, height);
    ellipse(px, py, playerSize,playerSize);
    
    fill(0);
    rect(0,height, width,-250);
  }
  else {
    noSmooth();
    image(levelImage, 0, 0, 200, 100);    // show at 200x100px size
    
    noStroke();
    fill(255,150,0, 200);
    smooth();
    float px = map(playerX, 0, w, 0, 200);
    float py = map(playerY, 0, h, 0, 100);
    ellipse(px, py, playerSize,playerSize);
  }
}

