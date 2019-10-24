/* 
 * Strings, but comparisons are counted
 */

public class MyString implements Comparable<MyString> {

    private String s;
    private static int c; // comparison counts

    public MyString(String s) { this.s = s; }

    public String val() { return s; }

    public String toString() { return s; }

    public static void resetComparisons() { c = 0; }

    public static int noComparisons() { return c; }

    public int compareTo(MyString t) { c++; return s.compareTo(t.val()); }

}
