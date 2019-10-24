/*
 * $ java-introcs RandomInts 1000000 10000 -s > 1000000_10000s.in
 * $ java-introcs RandomInts 1000000 10000 > 1000000_10000.in
 * $ java-introcs RandomInts 1000000 10 -s > 1000000_10s.in
 * $ java-introcs RandomInts 1000000 10 > 1000000_10.in
 */

import java.util.Arrays;

public class RandomInts {

    public static void main(String[] args) {
	int N = Integer.parseInt(args[0]);
	int M = Integer.parseInt(args[1]);
	boolean sorted = args.length > 2;
	int[] a = new int[N];
	for (int i = 0; i < N; i++) 
	    a[i] = StdRandom.uniform(M);
	if (sorted)
	    Arrays.sort(a);
	for (int x : a) 
	    StdOut.println(x);
    }
}
