void setup() {
  fullScreen();
  frameRate(240);
}

boolean runningGame=false;
Point[][] grid = new Point[9][9];

void draw() {
  if(!runningGame) {
      background(255);
      textSize(128);
      text("Weiqi", width/2, height/3);
      fill(0);
      textAlign(CENTER,CENTER);
    
      fill(128);
      rectMode(RADIUS);
      rect(width/2, 2*(height/3), 300, 100);
      
      fill(0);
      textSize(86);
      text("New Game", width/2, 2*(height/3));
    
      int lastMouseX = mouseX;
      int lastMouseY = mouseY;
    
      if(mousePressed==true && lastMouseX>(width/2-150) && lastMouseX<(width/2+150) && lastMouseY>(2*(height/3)-50) && lastMouseY<(2*(height/3)+50)) {
        
        //initialize grid, starting with 9x9 grid of points
      
        drawPoint(width/2, height/2);
        
        float startingX = (width/2)-400;
        float startingY = (height/2)-400;

        for(int i=0; i<=9; i++) {
          for(int j=0; j<=9; j++) {
            Point p = new Point(startingX,startingY);
            grid[i][j] = p;
            drawPoint(startingX,startingY);
            startingX+=100;
          }
          startingX = (width/2)-400;
          startingY+=100;
        }
        
        runningGame=true;
      }
    } else {
      background(252,212,156);
      

      
  }
}

void drawPoint(float x, float y) {
  circle(x, y, 30);
}
