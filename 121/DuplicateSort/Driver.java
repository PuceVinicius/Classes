/*
 * $ java-introcs Generator 2000000 4 abc | java-introcs Driver
 * No of comparisons: 39195428
 * No of comparisons: 44525673
 * No of comparisons: 13036809
 * $ java-introcs Generator 4000000 4 abc | java-introcs Driver
 * No of comparisons: 82366477
 * No of comparisons: 88794693
 * No of comparisons: 26077671
 * $ java-introcs Generator 8000000 4 abc | java-introcs Driver
 * No of comparisons: 172678339
 * No of comparisons: 193022981
 * No of comparisons: 52152707
 * $ java-introcs Generator 8000000 3 abc | java-introcs Driver
 * No of comparisons: 171008659
 * No of comparisons: 186518385
 * No of comparisons: 40293578
 * $ java-introcs Generator 8000000 2 abc | java-introcs Driver
 * No of comparisons: 165567429
 * No of comparisons: 182377520
 * No of comparisons: 30222399
 * $ java-introcs Generator 8000000 2 ab | java-introcs Driver
 * No of comparisons: 154642854
 * No of comparisons: 180738854
 * No of comparisons: 24003276
 * $ 
 */

public class Driver {

    public static void main(String[] args) {
	boolean verbose = args.length > 0;
        String[] a = StdIn.readAllStrings();
	MyString[] b = new MyString[a.length];

	for (int i = 0; i < a.length; i++)
	    b[i] = new MyString(a[i]);
	MyString.resetComparisons();
	Merge.sort(b);
	if (verbose)
	    for (MyString s : b)
		StdOut.println(s.val());
	StdOut.println("No of comparisons: " + MyString.noComparisons());

	for (int i = 0; i < a.length; i++)
	    b[i] = new MyString(a[i]);
	MyString.resetComparisons();
    Quick.sort(b);
	if (verbose)
	    for (MyString s : b)
		StdOut.println(s.val());
	StdOut.println("No of comparisons: " + MyString.noComparisons());

	for (int i = 0; i < a.length; i++)
	    b[i] = new MyString(a[i]);
	MyString.resetComparisons();
	QuickX.sort(b);
	if (verbose)
	    for (MyString s : b)
		StdOut.println(s.val());
	StdOut.println("No of comparisons: " + MyString.noComparisons());
    }
}
