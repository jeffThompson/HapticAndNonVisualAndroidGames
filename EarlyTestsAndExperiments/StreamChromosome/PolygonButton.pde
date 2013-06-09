
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
        isClicked = true;
      }
    }
  }

  void display() {
    if (isClicked) fill(255, 200);
    else fill(c);
    beginShape();
    for (int i=0; i<numVertices; i++) {
      vertex(vertX[i], vertY[i]);
    }
    endShape(CLOSE);
  }
}
