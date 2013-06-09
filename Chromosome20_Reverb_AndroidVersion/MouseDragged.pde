
@Override
public boolean dispatchTouchEvent(MotionEvent event) {
  int action = event.getActionMasked();

  // touch to clear title screen and start gameplay
  if (startScreen && action == MotionEvent.ACTION_DOWN) {
    startScreen = false;
  } 

  // drag to move player
  else if (action == MotionEvent.ACTION_UP) {    // also try ACTION_MOVE
    int diffX = mouseX - pmouseX;
    int diffY = mouseY - pmouseY; 

    if (abs(diffX) < abs(diffY)) {

      // UP
      if (diffY > 0) {
        if (playerY-1 < 0 && level.pixels[(level.height-1) * level.width + playerX] != bgColor) {
          playerY = level.height-1;
          playFootsteps();
        }
        else if (level.pixels[(playerY-1) * level.width + playerX] != bgColor) {
          playerY -= 1;
          playFootsteps();
        }
      }

      // DOWN
      else {
        if (playerY+1 > level.height-1 && level.pixels[playerX] != bgColor) {
          playerY = 0;
          playFootsteps();
        }
        else if (level.pixels[(playerY+1) * level.width + playerX] != bgColor) {
          playerY += 1;
          playFootsteps();
        }
      }
    }
    else {

      // RIGHT
      if (diffX < 0) {
        if (playerX+1 > level.width-1 && level.pixels[playerY * level.width] != bgColor) {
          playerX = 0;
          playFootsteps();
        }
        else if (level.pixels[playerY * level.width + playerX+1] != bgColor) {
          playerX += 1;
          playFootsteps();
        }
      }

      // LEFT
      else {
        if (playerX-1 < 0 && level.pixels[playerY * level.width + level.width-1] != bgColor) {
          playerX = level.width-1;
          playFootsteps();
        }
        else if (level.pixels[playerY * level.width + playerX-1] != bgColor) {
          playerX -= 1;
          playFootsteps();
        }
      }
    }
  }
  
  return super.dispatchTouchEvent(event);        // pass data along when done!
}

