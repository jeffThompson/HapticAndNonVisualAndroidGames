/*
TIERED DNA
Jeff Thompson | 2013 | www.jeffreythompson.org

*/

String filename = "Chromosome20.txt";  // data file to read
BufferedReader reader;
Point[] pts = new Point[0];

float rx, ry;
float rotInc = 0.005;

void setup() {
  size(900,500, OPENGL);
  
  println("Creating level...");
  createLevelImage();
  println("DONE!");
  
  rx = radians(-25);
  ry = radians(45);
}

void draw() {
  background(0);
  
  translate(width/2, height/2, 0);
  rotateX(rx);
  rotateY(ry);  
    
  float px = 0;
  float py = 0;
  float pz = 0;
  
  stroke(255);
  for (Point p : pts) {
    line(py,px,pz, p.y,p.x,p.z);
    px = p.x;
    py = p.y;
    pz = p.z;
  }
}

void mouseDragged() {
  rx += (pmouseY-mouseY) * rotInc;
  ry += (pmouseX-mouseX) * -rotInc;
}

class Point {
  float x, y, z;
  Point (float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
  }
}
