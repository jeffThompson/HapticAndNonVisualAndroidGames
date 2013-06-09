
// instantiate buttons (messy, so diverted here)
void createButtons() {
  upButton = new PolygonButton(new float[] { 0, width/2-gridSize/2, width/2+gridSize/2, width }, new float[] { 0, height/2-gridSize/2, height/2-gridSize/2, 0 }, color(0));
  rightButton = new PolygonButton(new float[] { 0, width/2-gridSize/2, width/2-gridSize/2, 0 }, new float[] { 0, height/2-gridSize/2, height/2+gridSize/2, height }, color(0));
  downButton = new PolygonButton(new float[] { 0, width/2-gridSize/2, width/2+gridSize/2, width }, new float[] { height, height/2+gridSize/2, height/2+gridSize/2, height }, color(0));
  leftButton = new PolygonButton(new float[] { width, width/2+gridSize/2, width/2+gridSize/2, width }, new float[] { 0, height/2-gridSize/2, height/2+gridSize/2, height }, color(0));
  centerButton = new CenterButton(gridSize, color(255,150,0), color(255,0,0));
}
