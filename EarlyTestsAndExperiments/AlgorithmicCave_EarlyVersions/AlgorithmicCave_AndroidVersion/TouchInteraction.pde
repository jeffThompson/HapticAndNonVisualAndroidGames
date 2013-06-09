
// handled with KeyPressed() is desktop version

@Override
public boolean dispatchTouchEvent(MotionEvent event) {
  int action = event.getActionMasked();
  if (action == MotionEvent.ACTION_UP) {    // also try ACTION_MOVE

    int diffX = mouseX - pmouseX;
    int diffY = mouseY - pmouseY;

    // y direction - up moves forward in direction player is facing
    if (abs(diffX) < abs(diffY)) {
      if (diffY > 0) {        
        if (direction == 'n' && level[playerY-1][playerX] != STONE) {
          playerY -= 1;
          playFootstep();
        } 
        else if (direction == 'e' && level[playerY][playerX+1] != STONE) {
          playerX += 1;
          playFootstep();
        }
        else if (direction == 's' && level[playerY+1][playerX] != STONE) {
          playerY += 1;
          playFootstep();
        }
        else if (direction == 'w' && level[playerY][playerX-1] != STONE) {
          playerX -= 1;
          playFootstep();
        }
      }
    }

    // x changes direction player is facing
    else {
      if (diffX > 0) {    // rotate left
        switch (direction) {
        case 'n': 
          direction = 'w'; 
          break;
        case 'e': 
          direction = 'n'; 
          break;
        case 's': 
          direction = 'e'; 
          break;
        case 'w': 
          direction = 's'; 
          break;
        }
      }
      else {              // rotate right
        switch (direction) {
        case 'n': 
          direction = 'e'; 
          break;
        case 'e': 
          direction = 's'; 
          break;
        case 's': 
          direction = 'w'; 
          break;
        case 'w': 
          direction = 'n'; 
          break;
        }
      }
    }
  }
  return super.dispatchTouchEvent(event);        // pass data along when done!
}

