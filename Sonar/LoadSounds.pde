
void loadSounds() {
  try {
    
    // sonar sweep
    sonarSweep = new MediaPlayer();
    AssetManager assets = this.getAssets();
    AssetFileDescriptor fd = assets.openFd(sonarSweepFilename);
    sonarSweep.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    sonarSweep.prepare();
    
    // if specified, center click for sonar sweep
    centerClick = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd(centerClickFilename);
    centerClick.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    centerClick.prepare();

    // when hitting obstacle
    hitSound = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd(hitSoundFilename);
    hitSound.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    hitSound.prepare();
    
    // sound when hitting edge of screen
    // via: http://soundbible.com/1442-Cupboard-Door-Close.html
    sideSound = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd(sideSoundFilename);
    sideSound.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    sideSound.prepare();
  }
  
  // any errors?
  catch (IOException ioe) {
    println("Error (probably could not find/load the audio file - is it in the sketch's data folder?)");
    println(ioe);
  }
}

