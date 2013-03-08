/*
BIG D-PAD
Jeff Thompson | 2013 | www.jeffreythompson.org


*/

int fireSize = 300;

void setup() {
  size(500,900);
  
  smooth();
  noStroke();
}

void draw() {
  
  // up
  fill(255,150,0);
  quad(0,0, width/2-fireSize/2,height/2-fireSize/2, width/2+fireSize/2, height/2-fireSize/2, width,0);
  
  // right
  fill(255,0,0);
  quad(0,0, width/2-fireSize/2,height/2-fireSize/2, width/2-fireSize/2, height/2+fireSize/2, 0,height);
  
  // down
  fill(255,150,0);
  quad(0,height, width/2-fireSize/2,height/2+fireSize/2, width/2+fireSize/2, height/2+fireSize/2, width,height);
  
  // left
  fill(255,0,0);
  quad(width,0, width/2+fireSize/2,height/2-fireSize/2, width/2+fireSize/2, height/2+fireSize/2, width,height);
  
  // fire button
  fill(255);
  rectMode(CENTER);
  rect(width/2, height/2, fireSize, fireSize);
}

