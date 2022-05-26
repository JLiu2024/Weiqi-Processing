import java.util.*;

public class Player {
    private double score;
    private int color;

    public Player(int color) {
        this.color = color;
    }

    public void addPoints(double toAdd) {
        score += toAdd;
    }
}