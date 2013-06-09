
void runSonarScan() {

  // scan sonar field
  beeps = new float[180];                 // one for each angle
  for (float beep : beeps) {                      // set to 0
    beep = 0;
  }

  for (Obstacle o : obstacles) {                  // add in obstacles

    float distColor = map(o.dist, 0, width, 255, 0);
    distColor = constrain(distColor, 0, 255);
    try {
      beeps[o.getAngleInDegrees()] = distColor;
    }
    catch (ArrayIndexOutOfBoundsException aioobe) {
      // if we go off the array, ignore
    }

    float lx = o.x + o.radius * cos(o.angle - HALF_PI);
    float ly = o.y + o.radius * sin(o.angle - HALF_PI);
    float rx = o.x + o.radius * cos(o.angle + HALF_PI);
    float ry = o.y + o.radius * sin(o.angle + HALF_PI);

    int angleL = int(degrees(atan2(ly-playerY, lx-playerX)));
    int angleR = int(degrees(atan2(ry-playerY, rx-playerX)));

    /*     
     int angleWidth = angleR - angleL;
     int a = int(degrees(o.angle));
     
     for (int i = -angleWidth/2; i < angleWidth/2; i++) {
     try {
     if (i < 0) {
     beeps[a + i] = max(beeps[a+i], map(i, -angleWidth/2, 0, 0, distColor));
     }
     else {
     beeps[a + i] = max(beeps[a+i], map(i, 0, angleWidth/2, distColor, 0));
     }
     }
     catch (ArrayIndexOutOfBoundsException aioobe) {
     // if we go off the array, ignore
     }
     }
     
     stroke(255, 150, 0, 100);
     line(playerX, playerY, lx, ly);
     line(playerX, playerY, rx, ry);
     */
  }

  // draw sonar field
  for (int i=0; i<beeps.length; i++) {  
    pushMatrix();
    translate(playerX, playerY);
    rotate(radians(i) + HALF_PI);
    stroke(beeps[i]);
    line(0, playerSize, 0, 60);
    popMatrix();
  }
}

