class Car {
  //data
  float x, y, size, dx, dy;
  color c;
  
  //constructor
  Car(float _x, float _y, float _size, color _c, float _dx, float _dy) {
    x = _x;
    y = _y;
    dy = _dy;
    size = _size;
    c = _c;
    dx = _dx;
  }

  //behavior
  void display() {
    // Using a local variable "offset"
    float offset = size/4;
    // Draw main car body
    rectMode(CENTER);
    stroke(200);
    fill(c);
    rect(x, y, size, size/2);
    // Draw four wheels relative to center
    fill(0);
    rect(x - offset, y - offset, offset, offset/2);
    rect(x + offset, y - offset, offset, offset/2);
    rect(x - offset, y + offset, offset, offset/2);
    rect(x + offset, y + offset, offset, offset/2);
  }

  void move() {
    x += dx;
    //move down at the same rate as the lanes
    y += dy;
  }

  boolean reset() {
    //returns true when car leaves screen
    if (x >= width && dx>0) {
      return true;
    }else if (x<0 && dx<0){
      return true;
    }
    return false;
  }
  
  boolean hitByCar() {
    //collision detection between frog and car
    float distance = dist(x, y, frog.x, frog.y);
    if (distance <= size/4 + frog.size/4) {
      return true;
    }
    return false;
  }
}