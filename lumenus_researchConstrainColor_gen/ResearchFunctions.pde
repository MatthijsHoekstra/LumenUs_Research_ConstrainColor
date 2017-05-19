void researchFunctions() {

  if (startTimer) {
    startTimeTimer = millis();

    startTimer = false;
  }
  
  
  // ---- Make all tubes white for research setting 1

  if (experimentNumberFinal == 1) {
    pushStyle();
    fill(255, 255, 255, 255);
    rect(0, 0, width, 300);
    popStyle();
  }
  
  // -----

  if (millis() > startTimeTimer + totalTimeTimer & inBetweenResearch == false) {
    inBetweenResearch = true;
    println("timer stopped + remove effects");
    
    for (int k=0; k<2; k++) { //Failsafe, react weird when just doing this loop one time
      for (int i=0; i < numTubes; i++) {
        for (int j=0; j < tubes[i].EffectBlocks.size(); j++) {
          tubes[i].EffectBlocks.remove(j);
          println("for loop remove block");
        }
      }
    }
  }

  if (inBetweenResearch) {
    currentTimeTimer = 0; 

    bgInBetweenResearch();
  }

  if (!inBetweenResearch) {
    currentTimeTimer = (millis() - startTimeTimer) / 1000;
  }
}

void createEffectBlock() {
  int randomTubeNumber = int(random(numTubes));

  tubes[randomTubeNumber].EffectBlocks.add(new EffectBlock(tubes[randomTubeNumber].tripodNumber, tubes[randomTubeNumber].tubeModulus, experimentNumberFinal, int(round(random(1))), false));
}


//TODO Fancy animations
void bgInBetweenResearch() {
  background(255, 0, 0);
}