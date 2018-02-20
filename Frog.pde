class Frog {
  //data
  float x, y, dy;
  int size;
  color frogColor;
  PImage frog;
  
  //constructor
  Frog(float _x, float _y, int _size, float _dy) {
    x = _x;
    y = _y;
    size = _size;
    dy = _dy;
    frog = loadImage("frog.png");
    frog.resize(0, size);
  }
  
  //behavior
  void display() {
    imageMode(CENTER);
    image(frog, x, y);
  }
  
  void die() {
    state = 4; //go to end screen
  }
  
  void move() {
    y+=dy; //moves down at the same rate as the lanes
  }
}