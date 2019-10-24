package pieces;

public class Nut {
    int d;

    public Nut(int d) { this.d = d; }

    int dimen() { return d; }

    public int compareTo(Bolt b) {
	return this.d - b.dimen();
    }
} 
