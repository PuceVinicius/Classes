import java.util.Arrays;

public class SuffixArrayJava6 {
    private final String[] suffixes;
    private final int n;

    public SuffixArrayJava6(String s) {
        n = s.length();
        suffixes = new String[n];
        for (int i = 0; i < n; i++)
            suffixes[i] = s.substring(i);
        Arrays.sort(suffixes);
    }

    // size of string
    public int length() {
        return n;
    }

    // index of ith sorted suffix
    public int index(int i) {
        return n - suffixes[i].length();
    }

    // ith sorted suffix
    public String select(int i) {
        return suffixes[i];
    }

    // number of suffixes strictly less than query
    public int rank(String query) {
        int lo = 0, hi = n - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            int cmp = query.compareTo(suffixes[mid]);
            if      (cmp < 0) hi = mid - 1;
            else if (cmp > 0) lo = mid + 1;
            else return mid;
        }
        return lo;
    } 

   // length of longest common prefix of s and t
    private static int lcp(String s, String t) {
        int n = Math.min(s.length(), t.length());
        for (int i = 0; i < n; i++)
            if (s.charAt(i) != t.charAt(i)) return i;
        return n;
    }

    // longest common prefix of suffixes(i) and suffixes(i-1)
    public int lcp(int i) {
        return lcp(suffixes[i], suffixes[i-1]);
    }

    // longest common prefix of suffixes(i) and suffixes(j)
    public int lcp(int i, int j) {
        return lcp(suffixes[i], suffixes[j]);
    }




    public static void main(String[] args) {
        String s = StdIn.readAll().replaceAll("\n", " ").trim();
        SuffixArrayJava6 suffix = new SuffixArrayJava6(s);


        StdOut.println("  i ind lcp rnk  select");
        StdOut.println("---------------------------");
        for (int i = 0; i < s.length(); i++) {
            int index = suffix.index(i);
            String ith = "\"" + s.substring(index, Math.min(index + 50, s.length())) + "\"";
            // String ith = suffix.select(i);
            int rank = suffix.rank(suffix.select(i));
            if (i == 0) {
                StdOut.printf("%3d %3d %3s %3d  %s\n", i, index, "-", rank, ith);
            }
            else {
                int lcp = suffix.lcp(i, i-1);
                StdOut.printf("%3d %3d %3d %3d  %s\n", i, index, lcp, rank, ith);
            }
        }
    }

}