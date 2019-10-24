import pieces.*;

public class NutsAndBolts {
    Nut[] nuts;
    Bolt[] bolts;
    int N; 

    public NutsAndBolts(int N, int t) {
	nuts = new Nut[N];
	bolts = new Bolt[N];
	this.N = N;

	int[] dimen = new int[N];

	// t distinct dimensions of nuts and bolts
	for (int i = 0; i < N; i++) {
	    dimen[i] = StdRandom.uniform(t); 
	    //StdOut.println(i + " " + dimen[i]);
	}

	for (int i = 0; i < N; i++) {
	    nuts[i] = new Nut(dimen[i]);
	    //StdOut.println(i + " " + nuts[i]);
	    StdOut.println(" " + dimen[i]);
	}

	// silly and evil
	StdRandom.shuffle(dimen);

	
	for (int i = 0; i < N; i++) {
		//StdOut.print(" " + dimen[i]);
	    bolts[i] = new Bolt(dimen[i]);
	    StdOut.println(i + " " + bolts[i]);
		}
    }

    public int N() { 
    	return N; 
    }

    public Nut[] nuts() { 
    	return nuts; 
    }

    public Bolt[] bolts() { 
    	return bolts; 
    }

    public int check() {
	for (int i = 0; i < N; i++)
	    if (nuts[i].compareTo(bolts[i]) != 0)
		return i;
	return -1; // success
    }

    public static void main(String[] args) {
	int N = Integer.parseInt(args[0]);
	int t = Integer.parseInt(args[1]);

	// N nuts and N bolts (random); unmatched
	NutsAndBolts nutsAndBolts = new NutsAndBolts(N, t);

	int i = nutsAndBolts.check();
	if (i < 0)
	    StdOut.println("Lucky!");
	else
	    StdOut.println("Unmatched pair: " + i);
    }

} 
