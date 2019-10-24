/*
 * $ java-introcs FilterByLength 6 < Pwords > words6p.txt
 */

public class FilterByLength {

    public static void main(String[] args) {
	int l = Integer.parseInt(args[0]);
	while (!StdIn.isEmpty()) {
	    String s = StdIn.readString();
	    if (s.length() == l) 
		StdOut.println(s);
	}
    }
    
}
