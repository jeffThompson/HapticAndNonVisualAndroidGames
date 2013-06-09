
void createButtons() {
  up = new PolygonButton(new float[] { 0, width/2-playerSize/2, width/2+playerSize/2, width }, new float[] { 0, height/2-playerSize/2, height/2-playerSize/2, 0 }, color(0));
  right = new PolygonButton(new float[] { 0, width/2-playerSize/2, width/2-playerSize/2, 0 }, new float[] { 0, height/2-playerSize/2, height/2+playerSize/2, height }, color(0));
  down = new PolygonButton(new float[] { 0, width/2-playerSize/2, width/2+playerSize/2, width }, new float[] { height, height/2+playerSize/2, height/2+playerSize/2, height }, color(0));
  left = new PolygonButton(new float[] { width, width/2+playerSize/2, width/2+playerSize/2, width }, new float[] { 0, height/2-playerSize/2, height/2+playerSize/2, height }, color(0));
}
