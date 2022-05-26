import java.util.*;

public class Player {
    private double score;
    private int color;
    private String passcode;
    private String name;

    public Player(int color, String passcode, String name) {
        this.color = color;
        this.passcode = passcode;
        this.name = name;
    }

    public void addPoints(double toAdd) {
        score += toAdd;
    }




}