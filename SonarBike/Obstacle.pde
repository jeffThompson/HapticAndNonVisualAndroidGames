
class Obstacle implements Comparator<Obstacle> {
  int x, y;
  float angle;
  
  Obstacle (int _x, int _y) {
    x = _x;
    y = _y;
    angle = degrees(atan2(y - levelHeight-1), x - playerX)) + 90;  // add 90º so L is 0º
  }
  
  int compareTo(Obstacle other) {
    return int(this.angle - other.angle);
  }
}
