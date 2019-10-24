/*
 * $ java-introcs TraceSize 100 899 1 400 10 abcd
 * $ java-introcs TraceSize 500 40499 10 500 10 abcd
 * $ java-introcs TraceSize 1000 43990 10 500 10 abcd
 */

public class TraceSize {

    private static void drawReference(double H, double W) {
	StdDraw.setPenRadius(.002);
	StdDraw.setPenColor(StdDraw.BLUE);
	StdDraw.line(0.0, H, W, H);
	StdDraw.setPenRadius(.005);
    }

    public static void main(String[] args) {
	int N = Integer.parseInt(args[0]);
	int T = Integer.parseInt(args[1]);
	int m = Integer.parseInt(args[2]);
	int W = Integer.parseInt(args[3]);
	int L = Integer.parseInt(args[4]);
	String alpha = args[5];

	// window of width W
	VisualAccumulator acc = new VisualAccumulator(2.0*N, W);

	BST<String, Integer> S = new BST<String, Integer>();

	for (int i = 0; i < N; i++) {
	    String s = Generator.randomString(L, alpha);
	    while (S.contains(s)) 
		s = Generator.randomString(L, alpha);
	    S.put(s, 0);
	    if (i % m == 0) {
		if (i/m % W == 0)
		    drawReference(N, W);
		acc.addDataValue(S.size());
	    }
	}
	for (int i = N; i < N + T; i++) {
	    double p = .5; 
	    if (StdRandom.bernoulli(p)) {
		String s = Generator.randomString(L, alpha);
		while (S.contains(s)) 
		    s = Generator.randomString(L, alpha);
		S.put(s, 0);
	    } else {
		if (S.isEmpty()) {
		    StdOut.println("Bankrupt!"); // terminology as in gambler's ruin
		    System.exit(0);
		}
		int r = StdRandom.uniform(S.size());
		String s = S.select(r);
		S.delete(s);
	    }
	    if (i % m == 0) {
		if (i/m % W == 0)
		    drawReference(N, W);
		acc.addDataValue(S.size());
	    }
	}
    }
}
