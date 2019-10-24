/******************************************************************************
 *
 * $ java-introcs WordCC words5.txt > word5.CC.out
 * $ java-introcs WordCC words6.txt > word6.CC.out
 * $ java-introcs Generator.java 50000 11 abcd > 50000.11.4.in
 * $ java-introcs WordCC 50000.11.4.in | head -n7
 * 
 ******************************************************************************/

import java.util.Arrays;
import java.util.Comparator;

public class WordCC {

    // return true if two strings differ in exactly one letter
    public static boolean isNeighbor(String a, String b) {
        int differ = 0;
        for (int i = 0; i < a.length(); i++) {
            if (a.charAt(i) != b.charAt(i)) differ++;
        }
        return (differ == 1);
    }

    private static final Comparator<Queue<String>> S_ORDER = new SOrderDecr();

    private static class SOrderDecr implements Comparator<Queue<String>> {
        public int compare(Queue<String> p, Queue<String> q) {
            if (p.size() < q.size()) return +1;
            if (p.size() > q.size()) return -1;
            return 0;
        }
    }

    public static void main(String[] args) {
	In in = new In(args[0]);
        Graph G = new Graph();
	
       /*******************************************************************
        *  Read a list of strings, all of the same length.
        *  At most 100000 words supported here.
        *******************************************************************/
        String[] words = new String[100000];
        int n = 0;
        while (!in.isEmpty()) {
	    String s = in.readString();
	    G.addVertex(s);
            words[n++] = s;
        }
	System.err.println("Finished reading word list");

       /*******************************************************************
        *  Insert connections between neighboring words into graph.
        *  This construction process can be improved from L n^2 to
        *  L n log n by sorting, where L = length of words.
        *******************************************************************/
        for (int i = 0; i < n; i++)
            for (int j = i+1; j < n; j++)
                if (isNeighbor(words[i], words[j]))
                    G.addEdge(words[i], words[j]);
	System.err.println("Finished building graph");
	System.err.println(G.V() + " vertices and " + G.E() + " edges");

	CC cc = new CC(G);
	int m = cc.count();
	StdOut.println(m + " components");
	Queue<String>[] components = (Queue<String>[]) new Queue[m];
	for (int i = 0; i < m; i++) 
	    components[i] = new Queue<String>();
	for (String v : G.vertices())
	    components[cc.id(v)].enqueue(v);

	Arrays.sort(components, new SOrderDecr());
		
	StdOut.println("Component sizes:");
        for (int i = 0; i < m; i++) 
	    StdOut.println(components[i].size());
	StdOut.println("Components:");
	for (int i = 0; i < m; i++) {
	    for (String v : components[i]) 
		StdOut.print(v + " ");
	    StdOut.println();
	}
    }
}
