class Coin {
  //data
  float x, y, size, dy;

  //constructor
  Coin(float _x, float _y, float _size, float _dy) {
    x = _x;
    y = _y;
    size = _size;
    dy = _dy;
  }

  //behaviour
  void display() {
    ellipseMode(CENTER);
    fill(#EAD84C);
    noStroke();
    ellipse(x, y, size, size);
  }

  void move() {
    //move down at same rate as lanes
    y += dy;
  }

  void reset() {
    //redraw coins once they leave the screen 
    if (y >= height) {
      y = 0;
    }
  }

  boolean isCollected() {
    //collision between coin and frog
    float distBetweenCoinAndFrog = dist(x, y, frog.x, frog.y);
    if (distBetweenCoinAndFrog <= 30) {
      return true;
    }
    return false;
  }
}