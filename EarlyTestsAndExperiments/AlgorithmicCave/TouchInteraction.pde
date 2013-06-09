
@Override
public boolean dispatchTouchEvent(MotionEvent event) {
  int action = event.getActionMasked();
  
  // touch to clear title screen and start gameplay
  if (titleScreen && action == MotionEvent.ACTION_DOWN) {
    titleScreen = false;
  } 
  
  // drag to move player
  else if (action == MotionEvent.ACTION_UP) {    // also try ACTION_MOVE
    int diffX = mouseX - pmouseX;
    int diffY = mouseY - pmouseY; 

    if (abs(diffX) < abs(diffY)) {
      if (diffY > 0) {    // up
      direction = 'n';
      }
      else {    // down
        direction = 's';
      }
    }
    else {
      if (diffX < 0) {  // right
      direction = 'e';
      }
      else {
        direction = 'w';  // left 
      }
    }
    movePlayer();
  }
  return super.dispatchTouchEvent(event);        // pass data along when done!
}

void movePlayer() {
    if (direction == 'n') {          // move north
    if (playerY-1 < 0 && level[h-1][playerX] != 0) {
      playerY = h-1;
      playFootstep();
    } else if (playerY-1 >= 0 && level[playerY-1][playerX] != 0) {
      playerY -= 1;
      playFootstep();
    } else {
      vibe.vibrate(wallVibration);
    }
  } else if (direction == 'e') {     // move east 
    if (playerX+1 > w-1 && level[playerY][0] != 0) {
      playerX = 0;
      playFootstep();
    } else if (playerX+1 <= w-1 && level[playerY][playerX+1] != 0) {
      playerX += 1;
      playFootstep();
    } else {
      vibe.vibrate(wallVibration);
    }
  } else if (direction == 's') {     // move south 
    if (playerY+1 > h-1 && level[0][playerX] != 0) {
      playerY = 0;
      playFootstep();
    } else if (playerY+1 <= h-1 && level[playerY+1][playerX] != 0) {
      playerY += 1;
      playFootstep();
    } else {
      vibe.vibrate(wallVibration);
    }
  } else if (direction == 'w') {     // move west 
    if (playerX-1 < 0 && level[playerY][w-1] != 0) {
      playerX = w-1;
      playFootstep();
    } else if (playerX-1 >= 0 && level[playerY][playerX-1] != 0) {
      playerX -= 1;
      playFootstep();
    } else {
      vibe.vibrate(wallVibration);
    }
  }
}
