import processing.svg.*;

String[] quantumCorpusLoad;
String[] finalQuantumArray;
String dataSource = "final_data-from-qiskit";

//the big file
int shots = 8192; //must strictly be the number of shots sent to the quantum system NOT the number getting used N (they could be the same).
String[] preppedData;
String[][] preppedDataContainer;

int[][] layerKey; //each layer has at least one "correct value" stored here
int strokeColor = 0;

//compositional tweaks
float x, y = 300;
float xPrior, yPrior = 300; 
float r = 100;
int N = 264; //max is the shot count (8192)
int noiseMultiplier = 4;
int ringSize = 32;
//run quantum circuit at each step, ie. 16 times
int circuitLayers = 16;

void setup(){
  //beginRecord(SVG, "export-02.svg"); //uncomment to output svg
  background(255);
  size(1000,1000);
  pixelDensity(2);
  strokeWeight(0.5);
  noFill();
  stroke(0);
  makeKey();
  parseCorpus();
  parseSourceData();
  //endRecord(); //uncomment to output svg
}

void makeAllShapes() {
  for(int i=0; i<circuitLayers; i++){
    makeShape(i);
  }
}

void makeShape(int layer) {
  for(int i=0; i<N; i++){
    
    int quantumNoise = Integer.parseInt(preppedDataContainer[layer][i]);
    int priorNoise; // color the shape on the way down from the prior error
    
    if (i == 0) {
      priorNoise = layerKey[layer][0];
    } else {
      priorNoise = Integer.parseInt(preppedDataContainer[layer][i-1]);
    }
    
    if (quantumNoise == layerKey[layer][0] || quantumNoise == layerKey[layer][1] || quantumNoise == layerKey[layer][2] || quantumNoise == layerKey[layer][3] || quantumNoise == layerKey[layer][4] || quantumNoise == layerKey[layer][5] || quantumNoise == layerKey[layer][6] || quantumNoise == layerKey[layer][7]) {
      strokeColor = 0;
    } else {
      strokeColor = 255;
    }
    
    if (priorNoise != layerKey[layer][0] && priorNoise != layerKey[layer][1] && priorNoise != layerKey[layer][2] && priorNoise != layerKey[layer][3] && priorNoise != layerKey[layer][4] && priorNoise != layerKey[layer][5] && priorNoise != layerKey[layer][6] && priorNoise != layerKey[layer][7]) {
      strokeColor = 255;
    }
    
    stroke(strokeColor,0,0);
    
    
    r += (quantumNoise*noiseMultiplier) + (layer*ringSize);
    x = width/2 + r*cos(TWO_PI*i/N);
    y = height/2 + r*sin(TWO_PI*i/N);
    line(xPrior, yPrior, x, y);
    //get set for the next iteration
    xPrior = x;
    yPrior = y;
    r -= (quantumNoise*noiseMultiplier) + (layer*ringSize);
  }
  
  N += 40;
}


void parseCorpus() {
  quantumCorpusLoad = loadStrings(dataSource + ".txt");
  finalQuantumArray = quantumCorpusLoad[0].replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\\s", "").split(",");
}

void parseSourceData() {
  preppedData = new String [shots];
  preppedDataContainer = new String[circuitLayers][];
  for(int i=0; i<circuitLayers; i++){
    pushDataIntoArray(i);
    makeShape(i);
  }
}

void pushDataIntoArray(int index){ //something funky is happening here
  for(int i=0; i<shots; i++){
    preppedData[i] = finalQuantumArray[i+(index*shots)];
  }
  preppedDataContainer[index] = preppedData;
  println(preppedDataContainer[index][0]);
}

void makeKey() {
  //this key is based off the data from the jupyter notebook. copy/pasted over by hand. there is probably a better way to do it
  layerKey = new int [circuitLayers][2];

  layerKey = new int [circuitLayers][8]; // some layers have up to 8 values (aka, all values)

  layerKey[0][0] = 0;

  layerKey[1][0] = 0;
  layerKey[1][1] = 2;
  
  layerKey[2][0] = 0;
  layerKey[2][1] = 2;
  
  layerKey[3][0] = 0;
  layerKey[3][1] = 3;
  
  layerKey[4][0] = 0;
  layerKey[4][1] = 3;
  
  layerKey[5][0] = 0;
  layerKey[5][1] = 3;
  
  layerKey[6][0] = 0;
  layerKey[6][1] = 3;
  layerKey[6][2] = 4;
  layerKey[6][3] = 7;
  
  layerKey[7][0] = 0;
  layerKey[7][1] = 3;
  layerKey[7][2] = 4;
  layerKey[7][3] = 7;
  
  layerKey[8][0] = 0;
  layerKey[8][1] = 2;
  layerKey[8][2] = 4;
  layerKey[8][3] = 6;
  
  layerKey[9][0] = 0;
  layerKey[9][1] = 2;
  layerKey[9][2] = 4;
  layerKey[9][3] = 6;
  
  layerKey[10][0] = 0;
  layerKey[10][1] = 1;
  layerKey[10][2] = 2;
  layerKey[10][3] = 3;
  layerKey[10][4] = 4;
  layerKey[10][5] = 5;
  layerKey[10][6] = 6;
  layerKey[10][7] = 7;
  
  layerKey[11][0] = 0;
  layerKey[11][1] = 1;
  layerKey[11][2] = 2;
  layerKey[11][3] = 3;
  layerKey[11][4] = 4;
  layerKey[11][5] = 5;
  layerKey[11][6] = 6;
  layerKey[11][7] = 7;
  
  layerKey[12][0] = 0;
  layerKey[12][1] = 1;
  layerKey[12][2] = 2;
  layerKey[12][3] = 3;
  layerKey[12][4] = 4;
  layerKey[12][5] = 5;
  layerKey[12][6] = 6;
  layerKey[12][7] = 7;
  
  layerKey[13][0] = 0;
  layerKey[13][1] = 1;
  layerKey[13][2] = 2;
  layerKey[13][3] = 3;
  layerKey[13][4] = 4;
  layerKey[13][5] = 5;
  layerKey[13][6] = 6;
  layerKey[13][7] = 7;
  
  layerKey[14][0] = 0;
  layerKey[14][1] = 2;
  layerKey[14][2] = 4;
  layerKey[14][3] = 6;
  
  layerKey[15][0] = 0;
  layerKey[15][1] = 2;
  layerKey[15][2] = 4;
  layerKey[15][3] = 6;
}
