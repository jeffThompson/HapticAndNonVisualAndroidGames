
int numPx = 20;
int blinkTime = 150;

int[] level = new int[numPx];
int index = 0;
boolean drawIt = false;

void setup() {
  size(600, 250);

  for (int i=0; i<numPx; i++) {
    if (random(1) > 0.5) {
      level[i] = 1;
    } else {
      level[i] = 0;
    }
    print(level[i] + "  ");
  }
  println();

  frameRate(30);
  background(255,150,0);
}

void draw() {
  noStroke();
  fill(255, 150, 0, 10);
  rect(0,0, width,height);
  stroke(255, 100);
  line(width/2, 0, width/2, height);

  if (drawIt) {    
    background(255);
    noStroke();
    if (level[index] == 0) {
      background(0);
    } else {
      fill(int(map(index, 0, numPx, 255, 0)));
      rect(0, 0, width/2, height);
      fill(int(map(index, 0, numPx, 0, 255)));
      rect(width/2, 0, width/2, height);
    }

    stroke(255, 100);
    line(width/2, 0, width/2, height);

    index++;
    if (index >= numPx) {
      drawIt = false;
    }
    delay(blinkTime);
  }
}

void keyPressed() {
  index = 0;
  drawIt = true;
}

