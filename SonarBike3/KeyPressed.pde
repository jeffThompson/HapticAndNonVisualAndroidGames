
void keyPressed() {

  // during start menu, any key changes levels
  if (level.equals("start")) {
    level = "instruction_walk";
    checkLevel();      // updates all variables for first level
  }

  // instruction screens
  else if (level.equals("instruction_walk")) {
    level = "walk";
  }
  else if (level.equals("instruction_run")) {
    level = "run";
  }
  else if (level.equals("instruction_bike")) {
    level = "bike";
  }
  else if (level.equals("instruction_motorcycle")) {
    level = "motorcycle";
  }

  // all other levels
  else {

    // toggle blindless!
    if (key == 'b') {
      blind = !blind;
    }

    // spacebar to trigger sonar
    if (key == 32) {
      thread("playSweep");
    }

    // arrow keys to move
    if (key == CODED) {

      // update player position
      if (keyCode == RIGHT) {
        player.move(RIGHT);
      }
      else if (keyCode == LEFT) {
        player.move(LEFT);
      }

      // move obstacles down (walk level only)
      if (level.equals("walk") && keyCode == UP) {
        for (Obstacle obs : obstacles) {
          obs.y += player.speed;
          obs.updatePosition();
        }
      }
    }
  }
}

