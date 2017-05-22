class DBZ {
  int tubeModulus, tripodNumber;
  private int startTime, time, interTime, endTime;

  purpleRect p;
  blueRect b;
  sinRect s;
  whiteRect w;

  DBZ (int tubeModulus, int tripodNumber) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    p = new purpleRect();
    b = new blueRect();
    s = new sinRect();
    w = new whiteRect();

    startTime = millis();
    interTime = startTime+1000;
    endTime = startTime+4000;
  }

  boolean timeFinished() {
    if (millis() > endTime) {
      return true;
    } else {
      return false;
    }
  }

  void update() {

    time = millis()-startTime;

    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21);

    if (millis() < endTime) {
      p.update();
      b.update();
    }

    if (time >= 1000 && time <= 3500) {
      s.update();
    }
    if (time >= 3500 && time <= 4000) {
      w.update();
    }

    popMatrix();
  }


  class blueRect {
    int startTime; // start time
    int interTime; // filling time
    int endTime; // end of animation

    blueRect() {
      startTime = millis();

      interTime = startTime+1000; // 1 second to fill

      endTime = 4000; // total animation time of 4 seconds
    }

    void update() {
      noStroke();
      fill (0, 0, 255);


      if (millis() < interTime) {
        float currentTime = map(millis(), startTime, interTime, 0, (tubeLength/4)*3);
        rect(0, 0, currentTime, rectHeight);
      } else {
        rect(0, 0, tubeLength/2, rectHeight);
      }
    }
  }

  class purpleRect {
    int startTime; // start time
    int interTime; // filling time
    int endTime; // end of animation

    purpleRect() {
      startTime = millis();
      interTime = startTime+1000; // 1 second to fill
      endTime = 4000; // total animation time of 4 seconds
    }

    void update() {
      noStroke();
      fill (255, 0, 255);
      if (millis() <= interTime) {
        float currentTime = map (millis(), startTime, interTime, 0, -tubeLength/2);
        rect(tubeLength, 0, currentTime, rectHeight);
      } else {
        rect(tubeLength, 0, -tubeLength/2, rectHeight);
      }
    }
  }

  class sinRect {
    int startTime;
    int interTime;
    int endTime; 

    float sinLength;
    float a;

    sinRect() {
      startTime = millis();
      interTime = startTime+1000; // 1 second to fill
      endTime = startTime+3500; // total animation time of 4 seconds
    }

    void update() {
      noStroke();
      a = map(millis(), startTime, startTime + 1000, 0, PI/2);
      sinLength = (tubeLength/4)*sin(a*2);

      if (sinLength <= 0) {
        fill(255, 0, 255);
      } else if (sinLength >= 0) {
        fill(0, 0, 255);
      }

      if (millis() < endTime) {
        rect(tubeLength/2, 0, sinLength, rectHeight);
      }
    }
  }

  class whiteRect {
    int startTime;
    int interTime;
    int endTime;

    float x;
    float x2;

    whiteRect() {
      startTime = millis();
      interTime = startTime+1000;
      endTime = 4000;
    }

    void update () {
      noStroke();
      fill(255);

      x = map(millis()-startTime, 3500, 4000, 0, sqrt(tubeLength/2));
      x2 = sq(x);

      rect(tubeLength/2, 0, x2, rectHeight);
      rect(tubeLength/2, 0, -x2, rectHeight);
    }
  }

  boolean finished() {
    if (millis() > endTime) {
      return true;
    } else {
      return false;
    }
  }
}