
void movePlayer(int direction) {

  // get next direction in file
  nextDirection = UP;
  switch (data.charAt(pos+1)) {
  case 'a':
    nextDirection = UP;
    break;
  case 'c':
    nextDirection = RIGHT;
    break;
  case 'g':
    nextDirection = DOWN;
    break;
  case 't':
    nextDirection = LEFT;
    break;
  }

  // if we've specified the correct direction, move
  if (direction == nextDirection) {
    pos += 1;
    if (pos > data.length()-1) pos = 0;   // at end of chromosome? start over...

    switch (data.charAt(pos)) {
    case 'a':
      if (A.isPlaying()) A.seekTo(0);        // play audio
      else A.start();
      vibe.vibrate(footstepVibration, -1);   // play vibration pattern   
      break;
    case 'c':
      if (C.isPlaying()) C.seekTo(0);
      else C.start();
      vibe.vibrate(footstepVibration, -1);
      break;
    case 'g':
      if (G.isPlaying()) G.seekTo(0);
      else G.start();
      vibe.vibrate(footstepVibration, -1);
      break;
    case 't':
      if (A.isPlaying()) A.seekTo(0);
      else A.start();
      vibe.vibrate(footstepVibration, -1);
      break;
    }
  }

  // wrong direction = hit
  else {
    if (hitSound.isPlaying()) hitSound.seekTo(0);
    else hitSound.start();
    vibe.vibrate(hitVibration, -1);
  }
}

