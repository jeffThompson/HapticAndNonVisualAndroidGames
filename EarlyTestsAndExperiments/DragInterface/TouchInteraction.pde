
// details passed on afterwards using the super.dispatchTouchEvent()
@Override
public boolean dispatchTouchEvent(MotionEvent event) {
  int action = event.getActionMasked();
  if (action == MotionEvent.ACTION_UP) {
    int diffX = mouseX - pmouseX;
    int diffY = mouseY - pmouseY;
    if (abs(diffX) > abs(diffY)) {
      if (diffX > 0) {
        x -= inc;
        if (x < 0) {
          x = 255;
        }
      }
      else {
        x += inc;
        if (x > 255) {
          x = 0;
        }
      }
    }
    else {
      if (diffY > 0) {
        y += inc;
        if (y > 255) {
          y = 0;
        }
      }
      else {
        y -= inc;
        if (y < 0) {
          y = 255;
        }
      }
    }
  }
  return super.dispatchTouchEvent(event);        // pass data along when done!
}
