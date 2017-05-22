class Timer {

  int tubeModulus;
  int tripodNumber;
  int sideTouch;

  private int timeStart;
  
  boolean touchOnConstrain = false;

  Timer(int tubeModulus, int tripodNumber, int sideTouch, boolean touchOnConstrain) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    this.sideTouch = sideTouch;
    
    this.touchOnConstrain = touchOnConstrain;

    timeStart = millis();
  }

  void logTime() {

    int timeEnd = millis();

    int totalTouchTime = timeEnd - timeStart;

    if (!inBetweenResearch) {

      logTestPerson.println(timeStart + "," + totalTouchTime + ",location," + this.tripodNumber + "," + this.tubeModulus + "," + this.sideTouch + "," + this.touchOnConstrain);  

      println("touch logged, time touched: " + timeStart + "," + totalTouchTime + ",location," + this.tripodNumber + "," + this.tubeModulus + "," + this.sideTouch);
    }
  }
}