class Lane {
  //data
  float y, randomNum, startingPlace, laneSpeed;
  boolean direction;
  ArrayList<Car> cars;
  ArrayList<Coin> coins;
  Timer timer;

  //constructor
  Lane(float _y) {
    randomNum = random(0, 100); //randomizes the direction in which the cars will travel
    laneSpeed = 0.5;
    y = height/10*_y; 
    timer = new Timer(2500);
    cars = new ArrayList<Car>();
    if (randomNum < 50) {
      cars.add(new Car(0 + random(60, 100), y+30, random(25, 50), color(random(255), random(255), random(255)), random(1, 4), laneSpeed));
      startingPlace = 0;
    } else {
      cars.add(new Car(width - random(60, 100), y+30, random(25, 50), color(random(255), random(255), random(255)), random(-4, -1), laneSpeed));
      startingPlace = width;
    }
    coins = new ArrayList<Coin>();
    for (int i = 1; i >= 0; i--) { //makes coins
      coins.add(new Coin(random(width), y + 30, 15, laneSpeed));
    }
  }

  //behaviour
  void display() {
    move();//makes the lanes move
    for (float j = 30; j < width; j += 120) { //draws lanes
      stroke(#ffff00);
      strokeWeight(2);
      line(j, y, j + 60, y);
    }
    //redraws lanes once they leave the screen
    reset(); 
    //collision detection
    killFrog();
    collectCoin();
  }

  void move() {
    y += laneSpeed;
  }

  void displayCars() {
    for (int i = cars.size()-1; i >= 0; i--) {
      Car thisCar = cars.get(i);
      thisCar.move();
      thisCar.display();
      if (thisCar.reset()) {
        cars.remove(i);
      }
    }
    addNewCar();
    avoidCarCrash();
  }

  void addNewCar() {
    if (timer.isFinished() ) {
      if (startingPlace== width) {
        cars.add(new Car(startingPlace, y+30, random(25, 50), color(random(255), random(255), random(255)), random(-4, -1), laneSpeed));
      } else {
        cars.add(new Car(startingPlace, y+30, random(25, 50), color(random(255), random(255), random(255)), random(1, 4), laneSpeed));
      }
      timer.resetTimer( random(1000, 3000) );
    }
  }

  void avoidCarCrash() {
    //if car's speed is higher than the one in front of it, assume speed of car in front so that they don't drive over each other
    for (int i = 0; i < cars.size(); i++) {
      Car thisCar = cars.get(i);
      for (int j = 0; j < cars.size(); j++) {
        Car otherCar = cars.get(j);
        if (i != j) {
          float distanceBetweenCars = dist(thisCar.x, thisCar.y, otherCar.x, otherCar.y);
          if (distanceBetweenCars <= thisCar.size/2 + otherCar.size) {
            if ( thisCar.dx > otherCar.dx) {
              otherCar.dx = thisCar.dx;
            } else {
              thisCar.dx = otherCar.dx;
            }
          }
        }
      }
    }
  }

  void killFrog() {
    for (Car thisCar : cars) {
      if (thisCar.hitByCar()) {
        frog.die();
      }
    }
  }

  void reset() { //lanes
    if (y >= height) {
      y=0;
    }
  }

  void displayCoins() {
    for (Coin thisCoin : coins) {
      thisCoin.move();
      thisCoin.display();
      thisCoin.reset();
    }
  }

  void collectCoin() {
    //collision detection between frog and coin
    for (int i = coins.size() - 1; i >= 0; i--) {
      Coin thisCoin = coins.get(i);
      if (thisCoin.isCollected()) {
        coins.remove(i);
        if (state == 3) {
          score++;
        }
      }
    }
  }
}