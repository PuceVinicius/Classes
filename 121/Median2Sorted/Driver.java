/*
 * $ java-introcs Generator2 100 10 abc 2 > 100.10.abc.in
 * $ java-introcs Generator2 100000 10 abc 2 > 100000.10.abc.in
 * $ java-introcs Generator2 1000000 10 abc 2 > 1000000.10.abc.in
 * $ java-introcs Generator2 2000000 10 abcd 2 > 2000000.10.abcd.in
 * $ java-introcs Driver < 100.10.abc.in 
 * Max no of comparisons per item: 13
 * Average no of comparisons per item: 11.4
 * $ java-introcs Driver < 100000.10.abc.in 
 * Max no of comparisons per item: 33
 * Average no of comparisons per item: 31.28205
 * $ java-introcs Driver < 1000000.10.abc.in 
 * Max no of comparisons per item: 39
 * Average no of comparisons per item: 37.252301
 * $ java-introcs Driver < 2000000.10.abcd.in 
 * Max no of comparisons per item: 41
 * Average no of comparisons per item: 39.78968975
 * $ 
 */

import java.util.Arrays;

public class Driver {

    private static void merge(Comparable[] a, Comparable[] b, Comparable[] c) {
        int i = 0, j = 0;
	int n = a.length + b.length;
        for (int k = 0; k < n; k++) {
            if      (i == a.length)            c[k] = b[j++];
            else if (j == b.length)            c[k] = a[i++];
            else if (a[i].compareTo(b[j]) < 0) c[k] = a[i++];
            else                               c[k] = b[j++];
        }
    }

    public static void main(String[] args) {
	String[] a = StdIn.readLine().split("\\s");
	String[] b = StdIn.readLine().split("\\s");
	MyString[] aa = new MyString[a.length];
	MyString[] bb = new MyString[b.length];
	for (int i = 0; i < a.length; i++)
	    aa[i] = new MyString(a[i]);
	for (int i = 0; i < b.length; i++)
	    bb[i] = new MyString(b[i]);

	String[] c = new String[a.length + b.length];
	merge(a, b, c);

	int N = a.length + b.length;
	int maxComps = -1;
	int totalComps = 0;

	for (int i = 0; i < N; i++) {
	    MyString.resetComparisons();
	    MyString s = (MyString)Median2Sorted.select(aa, bb, i);
	    if (!s.val().equals(c[i])) {
		StdOut.println("Panic! [Wrong for " + i + "]");
		System.exit(0);
	    }
	    if (MyString.noComparisons() > maxComps)
		maxComps = MyString.noComparisons();
	    totalComps += MyString.noComparisons();
	}
	StdOut.println("Max no of comparisons per item: " + maxComps);
	StdOut.println("Average no of comparisons per item: " + 1.0*totalComps/N);
    }

}
