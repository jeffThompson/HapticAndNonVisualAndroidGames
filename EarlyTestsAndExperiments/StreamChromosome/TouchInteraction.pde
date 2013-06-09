
@Override
public boolean dispatchTouchEvent(MotionEvent event) {

  int action = event.getActionMasked();

  // touch to clear title screen and start gameplay
  if (startScreen && action == MotionEvent.ACTION_DOWN) {
    startScreen = false;
  }

  // when pressed or dragged, check button states
  else if (!startScreen && (action == MotionEvent.ACTION_DOWN || action == MotionEvent.ACTION_MOVE)) {
    upButton.checkClick();
    rightButton.checkClick();
    downButton.checkClick();
    leftButton.checkClick();
    centerButton.checkClick();
  }

  // release triggers move and releases button
  else if (action == MotionEvent.ACTION_UP) {
    if (upButton.isClicked) {
      movePlayer(UP);
    }
    else if (rightButton.isClicked) {
      movePlayer(RIGHT);
    }
    else if (downButton.isClicked) {
      movePlayer(DOWN);
    }
    else if (leftButton.isClicked) {
      movePlayer(LEFT);
    }
    else if (centerButton.isClicked) {
      playSonar();
    }
  }

  // pass data along when done!
  return super.dispatchTouchEvent(event);
}

