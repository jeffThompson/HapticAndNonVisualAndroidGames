/*
BIG D-PAD
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 
 */

int fireSize = 100;
PolygonButton up, right, down, left;

void setup() {
  size(500, 900);

  smooth();
  noStroke();

  mouseX = width/2;
  mouseY = height/2;

  // create buttons
  up = new PolygonButton(new float[] {
    0, width/2-fireSize/2, width/2+fireSize/2, width
  }
  , new float[] {
    0, height/2-fireSize/2, height/2-fireSize/2, 0
  }
  , color(255, 150, 0));

  right = new PolygonButton(new float[] {
    0, width/2-fireSize/2, width/2-fireSize/2, 0
  }
  , new float[] {
    0, height/2-fireSize/2, height/2+fireSize/2, height
  }
  , color(255, 0, 0));

  down = new PolygonButton(new float[] {
    0, width/2-fireSize/2, width/2+fireSize/2, width
  }
  , new float[] {
    height, height/2+fireSize/2, height/2+fireSize/2, height
  }
  , color(255, 150, 0));

  left = new PolygonButton(new float[] {
    width, width/2+fireSize/2, width/2+fireSize/2, width
  }
  , new float[] {
    0, height/2-fireSize/2, height/2+fireSize/2, height
  }
  , color(255, 0, 0));
}

void draw() {
  up.display();
  right.display();
  down.display();
  left.display();    

  // fire button
  if (up.isClicked || right.isClicked || down.isClicked || left.isClicked) {
    fill(0);
  }
  else {
    fill(255);
  }
  rectMode(CENTER);
  rect(width/2, height/2, fireSize, fireSize);
}

void mousePressed() {
  up.checkClick();
  right.checkClick();
  down.checkClick();
  left.checkClick();
}
void mouseDragged() {
  up.checkClick();
  right.checkClick();
  down.checkClick();
  left.checkClick();
}

// on release, turn off all buttons
void mouseReleased() {
  up.isClicked = false;
  right.isClicked = false;
  down.isClicked = false;
  left.isClicked = false;
}

class PolygonButton {

  float[] vertX, vertY;
  int numVertices;
  color c;
  boolean isClicked;

  PolygonButton (float[] _vertX, float[] _vertY, color _c) {
    vertX = _vertX;
    vertY = _vertY;
    numVertices = vertX.length;
    c = _c;
    isClicked = false;
  }

  void checkClick() {
    int px = mouseX;
    int py = mouseY;

    isClicked = false;
    for (int i=0, j=numVertices-1; i < numVertices; j = i++) {
      if ( ((vertY[i]>py) != (vertY[j]>py)) && (px < (vertX[j]-vertX[i]) * (py-vertY[i]) / (vertY[j]-vertY[i]) + vertX[i]) ) {
        isClicked = !isClicked;
      }
    }
  }

  void display() {
    fill(c);
    beginShape();
    for (int i=0; i<numVertices; i++) {
      vertex(vertX[i], vertY[i]);
    }
    endShape(CLOSE);

    if (isClicked) {
      fill(0, 200);
      beginShape();
      for (int i=0; i<numVertices; i++) {
        vertex(vertX[i], vertY[i]);
      }
      endShape(CLOSE);
    }
  }
}

