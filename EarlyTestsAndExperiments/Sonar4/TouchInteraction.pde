

@Override
public boolean dispatchTouchEvent(MotionEvent event) {
  int action = event.getActionMasked();
  
  if (action == MotionEvent.ACTION_UP && !sonar.isPlaying) {
    thread("playSweep");
  }
  
  return super.dispatchTouchEvent(event);        // pass data along when done!
}
