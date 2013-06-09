
int tilesW = 5;
int tilesH = 12;
int playerWidth = 60;

Player player;
Tile[][] tiles = new Tile[tilesH][tilesW];
int tileWidth, tileHeight;

void setup() {
  size(500, 900);
  smooth();
  noStroke();

  player = new Player(width/2, height/2-1, playerWidth, color(255, 100));

  tileWidth = width/tilesW;
  tileHeight = height/tilesH;

  for (int y=0; y<tilesH; y++) {
    for (int x=0; x<tilesW; x++) {
      // x and y position of upper-left corner onscreen, width/height, and tile code
      tiles[y][x] = new Tile(x*tileWidth, y*tileHeight, tileWidth, tileHeight, int(random(4)));
    }
  }
}

void draw() {

  stroke(255, 100);
  for (int y=0; y<tilesH; y++) {
    for (int x=0; x<tilesW; x++) {
      tiles[y][x].display(player);
    }
  }
  
  noStroke();
  player.display();
}

void mouseDragged() {
  player.update();
}


class Player {
  int x, y;
  int diameter;
  int radius;
  color fillColor;

  Player (int _x, int _y, int _diameter, color _c) {
    x = _x;
    y = _y;
    diameter = _diameter;
    radius = diameter/2;
    fillColor = _c;
  }

  void update() {
    if (mouseX > x-radius && mouseX < x+radius && mouseY > y-radius && mouseY < y+radius) {
      player.x = mouseX;
      player.y = mouseY;
    }
  }

  void display() {
    fill(fillColor);
    ellipse(x, y, diameter, diameter);
  }
}

class Tile {
  int x, y;    // screen x/y position of upper-left
  int w, h;
  color fillColor;

  Tile (int _x, int _y, int _w, int _h, int tileCode) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    switch (tileCode) {
      case 0: fillColor = color(255,150,0); break;
      case 1: fillColor = color(150,75,0); break;
      case 2: fillColor = color(75,0,0); break;
      case 3: fillColor = color(0); break;
    }
    
  }

  void display(Player p) {
    fill(fillColor);
    rect(x, y, w, h);
    if (p.x > x && p.x < x+w && p.y > y && p.y < y+h) {
      fill(255, 100);
      rect(x, y, w, h);
    }
  }
}

