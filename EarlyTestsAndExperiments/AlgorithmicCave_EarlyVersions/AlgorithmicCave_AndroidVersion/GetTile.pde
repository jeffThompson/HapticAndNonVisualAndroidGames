
color getTile(int tile) {
  color c = stoneTile;  // default to stone tile

  switch(tile) {
  case STONE:
    c = stoneTile;
    break;
  default:
    c = color(tile);
    break;
  }

  return c;
}
