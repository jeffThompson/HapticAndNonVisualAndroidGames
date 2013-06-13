
@Override
public boolean dispatchTouchEvent(MotionEvent event) {
  int action = event.getActionMasked();
  
  // tap to play sonar sweep
  if (!introScreen && action == MotionEvent.ACTION_UP && !sonar.isPlaying) {
    thread("playSweep");
  }
  
  // mouse press to leave intro screen
  else if (introScreen && action == MotionEvent.ACTION_DOWN) {
    introScreen = false;
  }
  
  // pass data along when done!
  return super.dispatchTouchEvent(event);
}
