//Casey Niu and Avani Saxena
//December 12, 2016
//Computer Science 30
//Pair Programming Assignment: Crossy Road Frog
//Instructions: 
//Use the arrow to move the frog, avoid cars and collect as many coins as you can!
//Extra for Experts:
//Five Classes
//Collision detection between frog and cars / coins

//declare variables
Frog frog;
Timer timeytime;
Lane[] lanes = new Lane[10];
int state, score;

void setup() {
  size(600, 600);
  //set variables
  state = 1;
  score = 0;
  frog = new Frog(width/2, 3*height/4+60, 40, 0.5);
  timeytime = new Timer(3000);
}

void draw() {
  //determine state based on which stage of the game the player is on
  if (state == 1) {
    startScreen();
  } else if (state == 2) {
    noCars();
  } else if (state == 3) {
    gameScreen();
  } else {
    endScreen();
  }
}

void keyPressed() {
  if (state == 3) { //moving the frog
    if (keyCode == UP && frog.y > 90) {
      frog.y -= 60;
    } else if (keyCode == DOWN && frog.y < height - 90) {
      frog.y += 60;
    } else if (keyCode == RIGHT && frog.x < width) {
      frog.x += 60;
    } else if (keyCode == LEFT && frog.x > 0) {
      frog.x -= 60;
    }
  } else if (state == 1 || state == 4) {//start the game
    if (key == ' ') {
      state = 2;
      timeytime.resetTimer(3000);
    }
  }
}

void startScreen() {
  background(0);
  PFont handwriting = createFont("Lucida Console", 20);
  textFont(handwriting);
  textAlign(CENTER, CENTER);
  text("CROSSY ROAD FROG", width/2, height/2 - 100);
  text("Press the space bar to play!", width/2, height/2);
}

void noCars() {
  background(150);
  //makes lanes and draws stationary lanes
  for (int i = 0; i < lanes.length; i++) {
    lanes[i] = new Lane(i);
    lanes[i].display();
  }
  //write countdown message
  fill(0);
  text("READY?", width/2, height/2 - 30);
  frog.y = 3*height/4+60;
  frog.x = width/2;
  frog.display();
  if (timeytime.isFinished()) {
    state = 3; //start game
    timeytime.resetTimer(1000);
    score = 0;
  }
}

void gameScreen() {
  background(150);
  if (!timeytime.isFinished()) {
    text("GO!", width/2, height/2); //write "go" as soon as the game starts for one second
  }
  frog.display();
  frog.move();
  for (int i = 0; i < lanes.length; i++) {
    lanes[i].display();
    lanes[i].displayCars();
    lanes[i].displayCoins();
  }
  //display score in top right-hand corner
  fill(0);
  text("Score: " + score, width - 60, 60);
}

void endScreen() {
  background(0);
  fill(255);
  text("RIP", width/2, height/2 - 30);
  text("U DEAD", width/2, height/2);
  text("Score: " + score, width/2, height/2 + 30);
}