
color getTile(int tile) {
  color c = grassTile;  // default to grass

  switch(tile) {
  case SEA:
    c = seaTile;
    break;
  case BEACH:
    c = beachTile;
    break;
  case GRASS:
    c = grassTile;
    break;
  case FOREST:
    c = forestTile;
    break;
  case ROCKS:
    c = rockTile;
    break;
  case MOUNTAIN:
    c = mountainTile;
    break;
  }

  return c;
}
