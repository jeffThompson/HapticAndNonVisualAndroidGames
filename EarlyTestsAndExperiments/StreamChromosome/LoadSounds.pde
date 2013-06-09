
void loadSounds() {
  try {
    C = new MediaPlayer();
    AssetManager assets = this.getAssets();
    AssetFileDescriptor fd = assets.openFd("C.wav");
    C.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    C.prepare();

    F = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd("F.wav");
    F.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    F.prepare();

    G = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd("G.wav");
    G.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    G.prepare();

    A = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd("A.wav");
    A.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    A.prepare();

    hitSound = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd("hit.wav");
    hitSound.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    hitSound.prepare();
    
    lowSonar = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd("lowSonar.wav");
    lowSonar.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    lowSonar.prepare();
    
    highSonar = new MediaPlayer();
    assets = this.getAssets();
    fd = assets.openFd("highSonar.wav");
    highSonar.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    highSonar.prepare();
  }
  catch (IOException ioe) {
    println("Error loading audio (Is the file in the sketch's data folder? Is it a wav or mp3?)");
  }
}

