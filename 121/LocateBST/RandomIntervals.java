/*
 * $ java-introcs RandomIntervals 200 100 5
 */

public class RandomIntervals {

    public static void main(String[] args) {
	int lambda0 = Integer.parseInt(args[0]); // intervals
	int lambda1 = Integer.parseInt(args[1]); // gaps
	int N = Integer.parseInt(args[2]);

	long x = 0; 
	for (int i = 0; i < N; i++) {
	    double jump = StdRandom.exp(1.0/lambda1);
	    x = Math.round(x + jump);
	    StdOut.print(x + " ");
	    jump = StdRandom.exp(1.0/lambda0);
	    x = Math.round(x + jump);
	    StdOut.println(x);
	}

    }
}
