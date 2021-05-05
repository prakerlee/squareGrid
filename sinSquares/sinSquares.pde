Squares[] squares = new Squares[441];
color c1 = color(86, 176, 215);
color c2 = color(5, 69, 97);
float squareSize = 16;
float padding = 29;
float margin = 16;
float rippleSpeed = 0.013;
PVector centerPos;
PVector squarePosition;
color lerpedColor;


void setup(){
  translate(width/2, height/2);
  size (600, 600);
  centerPos = new PVector(width/2, height/2);
  resetSquares();
  
}

void draw(){ 
  background(55, 55, 64);
  imageMode(CENTER);
  
  for(int i = 0; i < squares.length; i++){
    squares[i].display();
    squares[i].animate();
  }



}

class Squares {
  float freq = 0.005;
  float amp = 4.26;
  float rippleSpeed = 0.013;
  float startingSize = 16.667;
  float margin = 16;
  
  float xPos;
  float yPos;
  float xSize;
  float ySize;
  float index;
  
  float distanceFromCenter;

  Squares(color c1, float xPos, float yPos, float xSize, float ySize, float index){

  }
  
  void display(){
    fill(lerpedColor);
    imageMode(CENTER);
    rectMode(CENTER);
    rect(xPos, yPos, xSize, ySize);
  }
  
  void animate(){
    squarePosition = new PVector(xPos, yPos);
    distanceFromCenter = PVector.dist(squarePosition, centerPos);
    //println(squarePosition);
    
    //color stuff
    lerpedColor = lerpColor(c1, c2, 0.5*sin(millis() * freq * distanceFromCenter * rippleSpeed) + .5);
    
    //Oscillate
    xSize = sin(millis() * freq * distanceFromCenter * rippleSpeed) * amp + squareSize;
    ySize = xSize;
  }

}

void resetSquares() {
  //first, clear the squares array 
  //squares = [];

  //then, calculate how many squares to create:
  //int numberX = ceil((width-margin) / padding);
  //int numberY = ceil((height-margin) / padding);
  int numberX = 29;
  int numberY = 29;

  // re-intialize the squares, and lay them out in a grid
  for (int j = 0; j < numberY; j++) {
    for (int i = 0; i < numberX; i++) {
      int index = i + (j * numberX);
      float xPos = (i) * padding;
      float yPos = (j) * padding;
      xPos = map(xPos, 0, padding*(numberX-1), margin, width-margin);
      yPos = map(yPos, 0, padding*(numberY-1), margin, height-margin);
      println(xPos);
      
      if(index < 441){
        squares[index] = new Squares(c1, xPos, yPos, squareSize, squareSize, index);
        //println(xPos);
      }
    }
  }

  //Draw and update them before leaving reset squares function, for live update to work
  for (int i = 0; i < squares.length; i++) {
    squares[i].display();
    squares[i].animate();
  }
}
