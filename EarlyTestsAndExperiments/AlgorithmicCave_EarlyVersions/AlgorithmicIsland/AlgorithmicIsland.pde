
/*
SMELL GAME LEVEL TESTS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Ideas and To Do:
 + diagonal beach option?
 + Run forest fire simulation to set terrain
 
 */

// basic setup variables
int w = 200;                      // level dimensions in px
int h = 100;
int maxInsetMove = 4;             // amount the beach can move inward per step (up to edgeThresh)
int edgeThresh = min(w/2, h/2);   // furthest beach can erode in (here 1/2 the shortest window dimension)
boolean saveIt = true;            // save to file?

// # of each terrain to grow (vary to change makeup of island)
int numRanges = 80;
int numRocks = 120;
int numFields = 10;
int numForests = 80;

// colors for each tile
color seaTile = color(70, 150, 220);
color grassTile = color(75, 95, 40);
color beachTile = color(245, 210, 125);
color forestTile = color(7, 72, 10);
color mountainTile = color(95, 100, 105);
color rockTile = color(180);

// other variables
int[][] level = new int[h][w];
final int GRASS = 0;
final int SEA = 1;
final int BEACH = 2;
final int FOREST = 3;
final int MOUNTAIN = 4;
final int ROCKS = 5;


void setup() {
  size(w, h);

  //  for (int i=0; i<100; i++) {
  //    if (i%25 == 0 && i != 0) {
  //      maxInsetMove += 1;
  //    }
  createLevel(w, h, maxInsetMove, edgeThresh);
  displayLevel();

  if (saveIt) {
    incrementAndSave(sketchPath("") + "/output", 3);
  }
  //  }
}

void createLevel(int w, int h, int maxInsetMove, int edgeThresh) {

  // fill level with random tiles (weighted for certain tiles)
  /*
  // chance of each tile (grass default; range 0-100)
   int chanceForest = 40;
   int chanceRock = 7;
   int chanceMountain = 3;
   for (int y=0; y<h; y++) {
   for (int x=0; x<w; x++) {
   int rand = int(random(0, 100));
   if (rand > 0 && rand < chanceForest) {
   level[y][x] = FOREST;
   }
   else if (rand > chanceForest && rand < chanceForest+chanceRock) {
   level[y][x] = ROCKS;
   }
   else if (rand > chanceForest+chanceRock && rand < chanceForest+chanceRock+chanceMountain) {
   level[y][x] = MOUNTAIN;
   }
   else {
   level[y][x] = GRASS;    // grass is the default tile
   }
   }
   }*/

  // fill with default (grass)
  for (int y=1; y<h-1; y++) {
    for (int x=1; x<w-1; x++) {
      level[y][x] = GRASS;
    }
  }

  // grow some mountain ranges (doing this first seems to make more realistic chains of mountains)
  for (int mountain=0; mountain<numRanges; mountain++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(1, 60));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = MOUNTAIN;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }

  // grow rock fields
  for (int rock=0; rock<numRocks; rock++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(1, 60));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = ROCKS;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }

  // grow some forests too!
  for (int forest=0; forest<numForests; forest++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(10, 1500));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = FOREST;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }

  // finally, grow some fields to fill in
  for (int field=0; field<numFields; field++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(10, 1500));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = GRASS;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
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

  // create ocean: top
  int rx = 0;
  int ry = 0;
  while (rx < w) {
    for (int y=ry; y>=0; y--) {
      level[y][rx] = SEA;
    }
    level[ry+1][rx] = BEACH;

    rx += int(random(0, 2));
    rx = constrain(rx, 0, w);
    ry += int(random(-maxInsetMove, maxInsetMove));
    ry = constrain(ry, 0, edgeThresh);
  }

  // create ocean: bottom
  rx = 0;
  ry = height-1;
  while (rx < w) {
    for (int y=ry; y<h; y++) {
      level[y][rx] = SEA;
    }
    level[ry-1][rx] = BEACH;

    rx += int(random(0, 2));
    rx = constrain(rx, 0, w);
    ry += int(random(-maxInsetMove, maxInsetMove));
    ry = constrain(ry, height-edgeThresh, height-1);
  }

  // create ocean: left
  rx = 0;
  ry = 0;
  while (ry < h) {
    for (int x=rx; x>=0; x--) {
      level[ry][x] = SEA;
    }
    level[ry][rx+1] = BEACH;

    ry += int(random(0, 2));
    ry = constrain(ry, 0, h);
    rx += int(random(-maxInsetMove, maxInsetMove));
    rx = constrain(rx, 0, edgeThresh);
  }

  // create ocean: right
  rx = w-1;
  ry = 0;
  while (ry < h) {
    for (int x=rx; x<w; x++) {
      level[ry][x] = SEA;
    }
    level[ry][rx-1] = BEACH;

    ry += int(random(0, 2));
    ry = constrain(ry, 0, h);
    rx += int(random(-maxInsetMove, maxInsetMove));
    rx = constrain(rx, w-edgeThresh, w-1);
  }    

  // add beach along coastline
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      if (level[y][x] == SEA) {
        if (y-1 >= 0 && level[y-1][x] != SEA) {
          level[y-1][x] = BEACH;
        }
        if (y+1 < h && level[y+1][x] != SEA) {
          level[y+1][x] = BEACH;
        }
        if (x-1 >= 0 && level[y][x-1] != SEA) {
          level[y][x-1] = BEACH;
        }
        if (x+1 < w && level[y][x+1] != SEA) {
          level[y][x+1] = BEACH;
        }
      }
    }
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
}

void incrementAndSave(String folder, int leadingZeroes) {
  String name = "island";
  String separator = "_";
  String extension = "png";  

  int maxFileNumber = 0;
  try {
    File dir = new File(folder);
    File[] files = dir.listFiles(); 
    for (File f : files) {   
      String[] findFileNumber = match(f.getName(), ".*?" + separator + "([0-9].*?)\\." + extension);
      if (findFileNumber != null) {
        int number = Integer.parseInt(findFileNumber[1]);
        if (number > maxFileNumber) {
          maxFileNumber = number;
        }
      }
    }
  }
  catch (NullPointerException npe) {      // if folder doesn't exist, make it!
    File newDir = new File(folder);
    newDir.mkdir();
  }
  String nextNumber = nf((maxFileNumber+1), leadingZeroes);
  String outputFilename = name + separator + nextNumber + "." + extension;
  save(folder + "/" + outputFilename);
  println(outputFilename);
}

