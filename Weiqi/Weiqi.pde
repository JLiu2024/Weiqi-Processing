void setup() {
  fullScreen();
  frameRate(240);
}

boolean runningGame = false;
Point[][] grid = new Point[9][9];
int playerTurn = -1; //-1 is black, 1 is white
int lastMouseX = mouseX;
int lastMouseY = mouseY;
double blackScore = 5;
double whiteScore = 0;
boolean removingStones = false;
Player black = new Player(-1);
Player white = new Player(1);
boolean passedThisTurn = false;
int consecutivePasses = 0;
boolean gameEnded = false;
boolean blackPass = false;
boolean whitePass = false;

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

      if(gameEnded) {
        background(255);
        if(blackScore>whiteScore) {
          textSize(128);
          text("Black Wins!", width/2, height/2);
          fill(0);
          textAlign(CENTER,CENTER);
        } else if(blackScore<whiteScore) {
          textSize(128);
          text("White Wins!", width/2, height/2);
          fill(0);
          textAlign(CENTER,CENTER);
        } else {
          textSize(128);
          text("Draw!", width/2, height/2);
          fill(0);
          textAlign(CENTER,CENTER);
        }
      } else {
        background(252,212,156);

        rectMode(RADIUS);
        fill(255);
        rect((width/2)+600+(width-1200)/4,(height/2)-600,200,80);
        fill(0);
        if(!removingStones) {
          text("Remove", (width/2)+600+(width-1200)/4,(height/2)-600);
        } else {
          text("Cancel", (width/2)+600+(width-1200)/4,(height/2)-600);
        }

        if(removingStones) {
          fill(255);
          rect((width/2)+600+(width-1200)/4,(height/2)-400,200,80);
          fill(0);
          text("Confirm", (width/2)+600+(width-1200)/4,(height/2)-400);
        }

        fill(255);
        rect((width/2)+600+(width-1200)/4,(height/2)+600,200,80);
        fill(0);
        text("Pass", (width/2)+600+(width-1200)/4,(height/2)+600);

        fill(255);
        rect((width/2)-600-(width-1200)/4,(height/2)-600,300,80);
        fill(0);
        text("Black: " + blackScore, (width/2)-600-(width-1200)/4,(height/2)-600);

        fill(255);
        rect((width/2)-600-(width-1200)/4,(height/2)-400,300,80);
        fill(0);
        text("White: " + whiteScore, (width/2)-600-(width-1200)/4,(height/2)-400);

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
              if(grid[i][j].getSelected()) {
                markSelect(currentX,currentY);
              }
              
            } else if(grid[i][j].getStatus() < 0) {
              placeBlackStone(currentX,currentY);
              if(grid[i][j].getSelected()) {
                markSelect(currentX,currentY);
              }
            }
            
            currentX+=150;
          }
          currentX = (width/2)-600;
          currentY+=150;
      }

      if(blackPass && whitePass) {
        gameEnded=true;
      }
      
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

void markSelect(float x, float y) {
  fill(255,0,0);
  stroke(255,0,0);
  circle(x,y,50);
  fill(0);
  stroke(0);
}

void mouseClicked() {
  if(!runningGame && lastMouseX>(width/2-150) && lastMouseX<(width/2+150) && lastMouseY>(2*(height/3)-50) && lastMouseY<(2*(height/3)+50)) {
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

  } else if(runningGame && lastMouseX>((width/2)+600+(width-1200)/4-250) && lastMouseX<((width/2)+600+(width-1200)/4+250)  && lastMouseY>((height/2)-600-100) && lastMouseY<((height/2)-600+100)) {
    if(removingStones) {
      removingStones=false;
      for(int i=0; i<9; i++) {
        for(int j=0; j<9; j++) {
          grid[i][j].deselect();
        }
      }
    } else {
    removingStones=true;
    }
  } else if(runningGame && lastMouseX > (((width/2)+600+(width-1200)/4)-250) && lastMouseX < (((width/2)+600+(width-1200)/4)+250) && lastMouseY > (((height/2)+600)-100) && lastMouseY < (((height/2)+600)+100)) {
    if(playerTurn<0) {
      blackPass = true;
    } else {
      whitePass = true;
    }
  } else if(runningGame && !removingStones) {
    for(int i=0; i<9; i++) {
      for(int j=0; j<9; j++) {
        if(grid[i][j].wasClicked(lastMouseX,lastMouseY)) {
          grid[i][j].setStatus(playerTurn);

          if(playerTurn==1) {
            playerTurn=-1;
          } else {
            playerTurn=1;
          }
        }
      }
    }
  } else if(removingStones && lastMouseX > (((width/2)+600+(width-1200)/4)-250) && lastMouseX < (((width/2)+600+(width-1200)/4)+250) && lastMouseY > (((height/2)-400)-100) && lastMouseY < (((height/2)-400)+100)) {
    for(int i=0; i<9; i++) {
      for(int j=0; j<9; j++) {
        if(grid[i][j].getSelected()) {
          if(grid[i][j].getStatus()>0) {
            blackScore++;
            grid[i][j].deselect();
            grid[i][j].setStatus(0);
          } else {
            whiteScore++;
            grid[i][j].deselect();
            grid[i][j].setStatus(0);
          }
        }
      }
    }
    removingStones = false;
  } else if(runningGame && removingStones) {
    for(int i=0; i<9; i++) {
      for(int j=0; j<9; j++) {
        if(grid[i][j].wasSelected(lastMouseX,lastMouseY) && grid[i][j].getStatus()!=0) {
          if(!grid[i][j].getSelected()) {
            grid[i][j].select();
          } else {
            grid[i][j].deselect();
          }         
        }
      }
    }
  } 
}