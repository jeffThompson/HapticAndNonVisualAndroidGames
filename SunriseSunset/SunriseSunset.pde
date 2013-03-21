
int midpoint;
PImage mountain, mountainMask;
int top, bottom;
float sunSize;
color skyStart, skyEnd, sunColor, moonColor;
float moonSize, moonX, moonY;
float skyTint, mountainTint;
int[][] stars = new int[500][3];    // x, y, and size

void setup() {
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight);

  mountain = loadImage("mountain.png");
  mountainMask = loadImage("mountain_mask.png");
  noStroke();

  mouseX = width/2;
  mouseY = height/2;

  midpoint = height/2;
  top = 0;
  bottom = height-height/3;

  for (int i=0; i<stars.length; i++) {
    int largestDim = max(width,height) / 2;
    stars[i][0] = int(random(-largestDim, largestDim));    // +/- because we first translate to center
    stars[i][1] = int(random(-largestDim, largestDim));
    stars[i][2] = int(random(1, 5));
  }
}

void draw() {

  // sky
  // if the cursor is in the top half of the screen, create one gradient
  if (mouseY < midpoint) {
    skyStart = color(map(mouseY, 0, midpoint, 0, 2), map(mouseY, 0, midpoint, 10, 88), map(mouseY, 0, midpoint, 255, 189));
    skyEnd = color(map(mouseY, 0, midpoint, 255, 255), map(mouseY, 0, midpoint, 255, 150), map(mouseY, 0, midpoint, 255, 0));
  }
  // create a different gradient for the bottom
  else {
    skyStart = color(map(mouseY, midpoint, height, 2, 0), map(mouseY, midpoint, height, 88, 0), map(mouseY, midpoint, height, 189, 0));
    skyEnd = color(map(mouseY, midpoint, height, 255, 0), map(mouseY, midpoint, height, 150, 0), 0);
  }

  // use lerpColor() to create the gradient!
  for (int y=0; y<height; y++) {
    float lerpInterval = map(y, 0, height-height/3, 0, 1);
    color s = lerpColor(skyStart, skyEnd, lerpInterval);
    stroke(s);
    line(0, y, width, y);
  }

  // stars
  pushMatrix();
  translate(width/2, height/2);
  float angle = atan2(mouseY - height/2, mouseX - width/2) / 5;
  rotate(angle);
  stroke(255, map(mouseY, height/3, height-height/3, 0, 100));
  for (int i=0; i<stars.length; i++) {
    strokeWeight(stars[i][2]);
    point(stars[i][0], stars[i][1]);
  }
  noStroke();
  popMatrix();

  // sun
  sunColor = color(255, map(mouseY, top, bottom, 230, 0), 0);
  sunSize = map(mouseY, top, bottom, min(width, height)/12, min(width, height)/6);
  fill(sunColor, 100);
  ellipse(mouseX, mouseY, sunSize*1.2, sunSize*1.2);
  fill(sunColor);
  ellipse(mouseX, mouseY, sunSize, sunSize);

  // moon
  moonColor = color(map(mouseY, top, bottom, 204, 255), map(mouseY, top, bottom, 216, 255), map(mouseY, top, bottom, 109, 255));
  moonX = map(mouseX, 0, width, width, 0);
  moonY = map(mouseY, 0, height, height, 0);
  moonSize = map(mouseY, top, bottom, min(width, height)/14, min(width, height)/10);
  fill(moonColor, 100);
  ellipse(moonX, moonY, moonSize*1.2, moonSize*1.2);
  fill(moonColor);
  ellipse(moonX, moonY, moonSize, moonSize);

  // mountains
  noTint();
  image(mountain, 0, 0, width, height);

  // darken mountains
  mountainTint = constrain(map(mouseY, top, bottom, 0, 230), 0, 230);
  tint(255, mountainTint);
  image(mountainMask, 0, 0, width, height);
}

