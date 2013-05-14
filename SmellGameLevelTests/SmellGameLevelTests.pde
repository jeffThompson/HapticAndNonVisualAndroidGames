
/*
SMELL GAME LEVEL TESTS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Ideas:
 + Run forest fire simulation to set terrain
 
 */

int w = 200;
int h = 100;
int maxInsetMove = 2;   // amount the beach can move inward per step (up to edgeThresh)
int edgeThresh = 30;
boolean saveIt = true;

color seaTile = color(70, 150, 220);
color grassTile = color(75, 95, 40);
color beachTile = color(245, 210, 125);
color forestTile = color(7, 72, 10);
color mountainTile = color(95, 100, 105);
color rockTile = color(180);

int[][] level = new int[h][w];
final int GRASS = -1;
final int SEA = 1;
final int BEACH = 2;
final int FOREST = 3;
final int MOUNTAIN = 4;
final int ROCKS = 5;


void setup() {
  size(w, h);
  background(255, 0, 0);
  createBeach(w, h, maxInsetMove, edgeThresh);
  displayLevel();
}

void createBeach(int w, int h, int maxInsetMove, int edgeThresh) {

  // fill level with random tiles (weighted for certain tiles)
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      int rand = int(random(0, 100));
      if (rand > 0 && rand < 40) {
        level[y][x] = FOREST;
      }
      else if (rand > 40 && rand < 50) {
        level[y][x] = ROCKS;
      }
      else if (rand > 50 && rand < 55) {
        level[y][x] = MOUNTAIN;
      }
      else {
        level[y][x] = GRASS;    // grass is the default tile
      }
    }
  }

  // rocks around all mountains
  for (int y=1; y<h-1; y++) {
    for (int x=1; x<w-1; x++) {
      if (level[y][x] == MOUNTAIN) {
        if (level[y-1][x] != MOUNTAIN) {
          level[y-1][x] = ROCKS;
        }
        if (level[y+1][x] != MOUNTAIN) {
          level[y+1][x] = ROCKS;
        }
        if (level[y][x-1] != MOUNTAIN) {
          level[y][x-1] = ROCKS;
        }
        if (level[y][x+1] != MOUNTAIN) {
          level[y][x+1] = ROCKS;
        }
      }
    }
  }

  // top
  int rx = 0;
  int ry = 0;
  while (rx < w) {
    for (int y=ry; y>=0; y--) {
      level[y][rx] = SEA;
      try {
        if (level[ry][rx-1] != SEA) {
          level[ry][rx-1] = BEACH;
        }
        if (level[ry][rx+1] != SEA) {
          level[ry][rx+1] = BEACH;
        }
      }
      catch (Exception e) {
        //
      }
    }
    level[ry+1][rx] = BEACH;

    rx += int(random(0, 2));
    rx = constrain(rx, 0, w);
    ry += int(random(-maxInsetMove, maxInsetMove));
    ry = constrain(ry, 0, edgeThresh);
  }

  // bottom
  rx = 0;
  ry = height-1;
  while (rx < w) {
    for (int y=ry; y<h; y++) {
      level[y][rx] = SEA;
      try {
        if (level[ry][rx-1] != SEA) {
          level[ry][rx-1] = BEACH;
        }
        if (level[ry][rx+1] != SEA) {
          level[ry][rx+1] = BEACH;
        }
      }
      catch (Exception e) {
        //
      }
    }
    level[ry-1][rx] = BEACH;

    rx += int(random(0, 2));
    rx = constrain(rx, 0, w);
    ry += int(random(-maxInsetMove, maxInsetMove));
    ry = constrain(ry, height-edgeThresh, height-1);
  }

  // left
  rx = 0;
  ry = 0;
  while (ry < h) {
    for (int x=rx; x>=0; x--) {
      level[ry][x] = SEA;
      try {
        if (level[ry-1][rx] != SEA) {
          level[ry-1][rx] = BEACH;
        }
        if (level[ry+1][rx] != SEA) {
          level[ry+1][rx] = BEACH;
        }
      }
      catch (Exception e) {
        //
      }
    }
    level[ry][rx+1] = BEACH;

    ry += int(random(0, 2));
    ry = constrain(ry, 0, h);
    rx += int(random(-maxInsetMove, maxInsetMove));
    rx = constrain(rx, 0, edgeThresh);
  }

  // right
  rx = w-1;
  ry = 0;
  while (ry < h) {
    for (int x=rx; x<w; x++) {
      level[ry][x] = SEA;
      try {
        if (level[ry-1][rx] != SEA) {
          level[ry-1][rx] = BEACH;
        }
        if (level[ry+1][rx] != SEA) {
          level[ry+1][rx] = BEACH;
        }
      }
      catch (Exception e) {
        //
      }
    }
    level[ry][rx-1] = BEACH;

    ry += int(random(0, 2));
    ry = constrain(ry, 0, h);
    rx += int(random(-maxInsetMove, maxInsetMove));
    rx = constrain(rx, w-edgeThresh, w-1);
  }
}

void displayLevel() {
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    switch (level[i/width][i%width]) {
    case SEA: 
      pixels[i] = seaTile;
      break;
    case BEACH: 
      pixels[i] = beachTile; 
      break;
    case GRASS: 
      pixels[i] = grassTile; 
      break;
    case FOREST: 
      pixels[i] = forestTile; 
      break;
    case MOUNTAIN: 
      pixels[i] = mountainTile;
      break;
    case ROCKS:
      pixels[i] = rockTile;
      break;
    }
  }
  updatePixels();

  if (saveIt) {
    save("island.png");
  }
}

