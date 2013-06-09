
// test wav file from:
// http://www.soundjay.com/footsteps-1.html
void playFootstep() {

  if (!footsteps.isPlaying()) {
    footsteps.setAuxEffectSendLevel(1.0f);    // just dry recording
    footsteps.start();
  }

  /*switch (level[playerY][playerX]) {
   case BEACH:
   if (!beachSteps.isPlaying()) {
   beachSteps.start();
   }
   break;
   case GRASS:
   if (!grassSteps.isPlaying()) {
   grassSteps.start();
   }
   break;
   case FOREST:
   if (!forestSteps.isPlaying()) {
   forestSteps.start();
   }
   break;
   case ROCKS:
   if (!rocksSteps.isPlaying()) {
   rocksSteps.start();
   }
   break;
   case MOUNTAIN:
   if (!mountainSteps.isPlaying()) {
   mountainSteps.start();
   }
   break;
   }*/
}

