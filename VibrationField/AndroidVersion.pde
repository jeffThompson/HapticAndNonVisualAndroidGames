import android.content.Context;    // both imports required for vibration
import android.os.Vibrator;


/*
VIBRATION FIELD
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Note: you must add "VIBRATE" to the permissions for the sketch under
 Android > Sketch Permissions...
 
 */

int diffThresh = 5;                         // mouse position difference to trigger vibration

int w = 4;
int h = 8;
Tile[] tiles = new Tile[w*h];

int tileW, tileH;
Vibrator vibe;

void setup() {  
  orientation(PORTRAIT);
  smooth();
  noStroke();

  mouseX = width/2;
  mouseY = height/2;
  vibe = (Vibrator)getSystemService(Context.VIBRATOR_SERVICE);

  tileW = width/w;
  tileH = height/h;

  println("Generating tiles...");
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      tiles[y*w + x] = new Tile(x, y, tileW, tileH, w, h, int(random(0, 4)));    // x,y in array, size w/h, # tiles w/h, tile code (0-4)
    }
  }
}

void draw() {

  int pos = (mouseY/tileH)*w + (mouseX/tileW);
  for (Tile t : tiles) {
    if (t.pos == pos) {
      t.active = true;
    }
    else {
      t.active = false;
    }
    t.display();
  }
  
  if (abs(mouseX-pmouseX) > diffThresh && abs(mouseY-pmouseY) > diffThresh) {
    tiles[pos].vibrate();
  }

  // circle at mouse position
  noStroke();
  fill(255, 150);
  ellipse(mouseX, mouseY, 250, 250);
  stroke(0, 100);
  line(mouseX-20, mouseY, mouseX+20, mouseY);
  line(mouseX, mouseY-20, mouseX, mouseY+20);
}

class Tile {

  int x, y;
  int w, h;
  color c;
  long vibration;
  boolean active = false;
  int pos;

  color[] tileColors = { 
    color(255, 150, 0), 
    color(0, 255, 150), 
    color(45, 175, 15), 
    color(20, 160, 245)
  };

  long[] vibrations = {
    20, 40, 60, 80
  };

  Tile (int _x, int _y, int _w, int _h, int tx, int ty, int tileCode) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = tileColors[tileCode];
    vibration = vibrations[tileCode];
    pos = y*tx + x;
  }

  void vibrate() {
    vibe.vibrate(vibration);
  }

  void display() {
    stroke(0, 100);
    fill(c);
    rect(x*w, y*h, w, h);

    if (active) {
      fill(0, 100);
      rect(x*w, y*h, w, h);
    }
  }
}

