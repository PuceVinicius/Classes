package pieces;

public class Bolt {
    int d;

    public Bolt(int d) { this.d = d; }

    int dimen() { return d; }

    public int compareTo(Nut n) {
	return this.d - n.dimen();
    }
} 
