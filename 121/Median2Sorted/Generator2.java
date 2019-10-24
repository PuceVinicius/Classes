/*
 * $ java-introcs Generator2 10 3 abc 2
 * aab abc abc acb bab bab bac bbb cca ccb 
 * abc aca acc acc bab bac bac cbb cbc cbc 
 * yoshi@anon154 ~/Documents/www/2017ii/mac121/sink/Code/Median2Sorted
 * $ java-introcs Generator2 6 5 atcg 3
 * aaatg aacag cagtc ggagc tattt ttaac 
 * cgatg gacca tagtc tgatc ttggc tttgc 
 * cacct gtatg gttga gtttg ttgga tttta 
 * yoshi@anon154 ~/Documents/www/2017ii/mac121/sink/Code/Median2Sorted
 * $
 */

import java.util.Arrays;

public class Generator2 {

    public static String randomString(int L, String alpha) {
	char[] a = new char[L];
	for (int i = 0; i < L; i++)  { 
	    int t = StdRandom.uniform(alpha.length());
	    a[i] = alpha.charAt(t);
	}
	return new String(a);
    }
    
    public static void main(String[] args) {
	int N = Integer.parseInt(args[0]);
	int L = Integer.parseInt(args[1]);
	String alpha = args[2];
	int lines = Integer.parseInt(args[3]);
	while (lines-- > 0) {
	    String[] a = new String[N];
	    for (int i = 0; i < N; i++)
		a[i] = randomString(L, alpha);
	    Arrays.sort(a);
	    for (String s : a) 
		StdOut.print(s + " ");
	    StdOut.println();
	}
    }

}
