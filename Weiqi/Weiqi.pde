void setup() {
  fullScreen();
  frameRate(240);
}

boolean runningGame=false;
Point[][] grid = new Point[9][9];
int playerTurn = -1; //-1 is black, 1 is white
int lastMouseX = mouseX;
int lastMouseY = mouseY;
double blackScore = 5;
double whiteScore = 0;

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
    
      lastMouseX = mouseX;
      lastMouseY = mouseY;

    } else {
      //game being played

      background(252,212,156);

      float currentX = (width/2)-600;
      float currentY = (height/2)-600;
      
      strokeWeight(2);

      for(int i=0; i<9; i++) {
        line(currentX, currentY, currentX+1200, currentY);
        currentY+=150;
      }

      currentX = (width/2)-600;
      currentY = (height/2)-600;

      for(int i=0; i<9; i++) {
        line(currentX, currentY, currentX, currentY+1200);
        currentX+=150;
      }

      currentX = (width/2)-600;
      currentY = (height/2)-600;

      for(int i=0; i<9; i++) {
        for(int j=0; j<9; j++) {
          drawPoint(currentX,currentY);
          
          if(grid[i][j].getStatus() > 0) {
            placeWhiteStone(currentX,currentY);
          } else if(grid[i][j].getStatus() < 0) {
            placeBlackStone(currentX,currentY);
          }
          
          currentX+=150;
        }
        currentX = (width/2)-600;
        currentY+=150;
    }

    //last frame's game positions have been drawn. time to check for new inputs.
    lastMouseX = mouseX;
    lastMouseY = mouseY;
  }
}

void drawPoint(float x, float y) {
  circle(x, y, 30);
}

void placeWhiteStone(float x, float y) {
  fill(255);
  stroke(255);
  circle(x,y,150);
  fill(0);
  stroke(0);
}

void placeBlackStone(float x, float y) {
  circle(x,y,150);
}

void mouseClicked() {
  if(!runningGame&& lastMouseX>(width/2-150) && lastMouseX<(width/2+150) && lastMouseY>(2*(height/3)-50) && lastMouseY<(2*(height/3)+50)) {
    //initialize grid, start with 9x9 grid of points
      
    drawPoint(width/2, height/2);
    
    float currentX = (width/2)-600;
    float currentY = (height/2)-600;

    for(int i=0; i<9; i++) {
      for(int j=0; j<9; j++) {
        Point p = new Point(currentX,currentY);
        grid[i][j] = p;
        drawPoint(currentX,currentY);
        currentX+=150;
      }
      currentX = (width/2)-600;
      currentY+=150;
    }

    //now add the lines

    currentX = (width/2)-600;
    currentY = (height/2)-600;
    
    strokeWeight(2);

    for(int i=0; i<9; i++) {
      line(currentX, currentY, currentX+1200, currentY);
      currentY+=150;
    }

    currentX = (width/2)-600;
    currentY = (height/2)-600;

    for(int i=0; i<9; i++) {
      line(currentX, currentY, currentX, currentY+1200);
      currentX+=150;
    }
    
    runningGame=true;

  } else {
    for(int i=0; i<9; i++) {
      for(int j=0; j<9; j++) {
        if(grid[i][j].wasClicked(lastMouseX,lastMouseY)) {
          grid[i][j].setStatus(playerTurn);

          removeDeadStones();

          if(playerTurn==1) {
            playerTurn=-1;
          } else {
            playerTurn=1;
          }
        }
      }
    }
  }
}

void removeDeadStones() {
  for(int i=0; i<9; i++) {
    for(int j=0; j<9; j++) {
      if(grid[i][j].getStatus()!=0) {
        int thisStatus=grid[i][j].getStatus();


      }
    }
  }
}

boolean hasAdjacentStones(int x, int y, int status) {
  if(x!=0 && y!=0 && x!=8 && y!=8) {
    if(grid[x+1][y+1].getStatus()==status || grid[x-1][y+1].getStatus()==status || grid[x-1][y-1].getStatus()==status || grid[x+1][y-1].getStatus()==status) {
      return true;
    }
  }
  return false;
}