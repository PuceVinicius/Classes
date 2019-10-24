/*
 * $ java-introcs GenerateAndMatch 1000000 1000000
 * Success!
 * $ java-introcs GenerateAndMatch 1000000 100
 * Success!
 * $ java-introcs GenerateAndMatch 10000000 100
 * Success!
 * $
 */

import pieces.*;

public class GenerateAndMatch {

    public static void main(String[] args) {
	int N = Integer.parseInt(args[0]);
	int t = Integer.parseInt(args[1]);

	// N nuts and N bolts (random); unmatched
	NutsAndBolts nutsAndBolts = new NutsAndBolts(N, t);

	Match.match(nutsAndBolts);

	int i = nutsAndBolts.check();
	if (i < 0)
	    StdOut.println("Success!");
	else
	    StdOut.println("Unmatched pair: " + i);
    }
    
} 
