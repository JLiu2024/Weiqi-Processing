import java.util.*;

public class Point{
  private float xVal;
  private float yVal;
  private int status;
  
  public Point(float xVal, float yVal) {
    this.xVal = xVal;
    this.yVal = yVal;
    status = 0;
  }
  
  public boolean isPoint(float xLoc, float yLoc) {
    return(dist(xVal,yVal,xLoc,yLoc)<=15);
  }
  
  public void setStatus(int newStatus) {
    status = newStatus;
  }
  
  public double dist(
  float x1, 
  float y1, 
  float x2, 
  float   y2) {       
    return Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
  }

  public int getStatus() {
    return status;
  }
}
