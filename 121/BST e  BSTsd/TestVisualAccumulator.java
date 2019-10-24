/*
 * Algs4th, p. 95 (variand)
 * 

 */

public class TestVisualAccumulator {
    public static void main(String[] args)
    {
	int T = Integer.parseInt(args[0]);
	int W = Integer.parseInt(args[1]);
	VisualAccumulator a = new VisualAccumulator(1.0, W);
	for (int t = 0; t < T; t++)
	    a.addDataValue(StdRandom.uniform());
	StdOut.println(a);
    }
}
