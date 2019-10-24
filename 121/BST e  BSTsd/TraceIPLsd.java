/*
 * $ java-introcs TraceIPL 100 899 1 200 10 abcd
 * $ java-introcs TraceIPL 500 40499 10 500 10 abcd
 * $ java-introcs TraceIPL 1000 43990 10 500 10 abcd
 * $ java-introcs TraceIPL 1000 10000000 10000 335 10 abcd
 * $ java-introcs TraceIPL 10000 100000000 200000 510 10 abcd (takes quite long)
 */

public class TraceIPLsd {
    private static void drawReference(double H, double W) {
	StdDraw.setPenRadius(.002);
	StdDraw.setPenColor(StdDraw.BLUE);
	StdDraw.line(0.0, H, W, H);
	StdDraw.setPenRadius(.005);
    }

    public static void main(String[] args) {
	int N = Integer.parseInt(args[0]); // N > 0
	int T = Integer.parseInt(args[1]);
	int m = Integer.parseInt(args[2]);
	int W = Integer.parseInt(args[3]);
	int L = Integer.parseInt(args[4]);
	String alpha = args[5];

	// reference value
	double H = 2*Math.log(N) - 2*(2 - .57721);
	// window of width W
	VisualAccumulator acc = new VisualAccumulator(2*H, W);

	BSTsd<String, Integer> S = new BSTsd<String, Integer>();

	for (int i = 0; i < N; i++) {
	    String s = Generator.randomString(L, alpha);
	    while (S.contains(s)) 
		s = Generator.randomString(L, alpha);
	    S.put(s, 0);
	    if (i % m == 0) {
		if (i/m % W == 0)
		    drawReference(H, W);
		acc.addDataValue(S.ipl_ave());
	    }
	}
	for (int i = N; i < N + T; i++) {
	    int r = StdRandom.uniform(S.size());
	    String s = S.select(r);
	    S.delete(s);
	    s = Generator.randomString(L, alpha);
	    while (S.contains(s)) 
		s = Generator.randomString(L, alpha);
	    S.put(s, 0);
	    if (i % m == 0) {
		if (i/m % W == 0)
		    drawReference(H, W);
		acc.addDataValue(S.ipl_ave());
	    }

	}
    }
}
