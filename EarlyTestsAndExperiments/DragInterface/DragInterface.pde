import android.view.MotionEvent;    // required import for fancy touch access

/*
DRAG INTERFACE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
*/

int x, y;
int inc = 20;

void setup() {
  orientation(PORTRAIT);
  noStroke();
  x = 150;
  y = 150;
}

void draw() {
  fill(x, x/2, 0);
  triangle(0, 0, width, 0, 0, height);

  fill(y/2, 0, y);
  triangle(width, 0, width, height, 0, height);
}
