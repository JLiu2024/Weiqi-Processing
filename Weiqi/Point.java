import java.util.*;

public class Point{
  private float xVal;
  private float yVal;
  private int status;
  private boolean isSelected;
  
  public Point(float xVal, float yVal) {
    this.xVal = xVal;
    this.yVal = yVal;
    status = 0;
    isSelected = false;
  }
  
  public boolean wasClicked(float xLoc, float yLoc) {
    if (status == 0) {
      return (dist(xVal, yVal, xLoc, yLoc) <= 15);
    }
    return false;
  }
  
  public void setStatus(int newStatus) {
    status = newStatus;
  }
  
  public double dist(
  float x1, 
  float y1, 
  float x2, 
  float y2) {       
    return Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
  }

  public int getStatus() {
    return status;
  }

  public boolean wasSelected(float xLoc, float yLoc) {
    if (status == 0) {
      return (dist(xVal, yVal, xLoc, yLoc) <= 150);
    }
    return false;
  }

  public void select() {
    isSelected = true;
  }

  public void deselect() {
    isSelected = false;
  }

  public boolean getSelected() {
    return isSelected;
  }
}
