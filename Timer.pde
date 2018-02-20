class Timer {
  //data
  float amountOfTimeToWait, whenTimerStarted, elapsedTime;
  boolean timerIsStillGoing;

  //constructor
  Timer(float _amountOfTimeToWait) {
    resetTimer(_amountOfTimeToWait);
  }

  //behaviour
  boolean isFinished() {
    updateTimer();
    return !timerIsStillGoing;
  }

  void updateTimer() {
    elapsedTime = millis() - whenTimerStarted;
    if (elapsedTime >= amountOfTimeToWait) {
      timerIsStillGoing = false;
    }
  }

  void resetTimer(float _amountOfTimeToWait) {
    amountOfTimeToWait = _amountOfTimeToWait;
    timerIsStillGoing = true;
    whenTimerStarted = millis();
  }
}