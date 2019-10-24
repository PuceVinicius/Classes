/*
 * $ java-introcs RandomDG 10000 3 2 > 10000.3.2.in
 * $ java-introcs RandomDG 10000 3 8 > 10000.3.8.in
 * $ java-introcs RandomDG 100000 3 4 > 100000.3.4.in
 * $ java-introcs RandomDG 200000 3 8 > 200000.3.8.in
 */

public class RandomDG {

    public static void main(String[] args) {
	int N = Integer.parseInt(args[0]);
	int k = Integer.parseInt(args[1]); // k-out
	int W = Integer.parseInt(args[2]); // W = 0 uniform

	Digraph G = new Digraph(N);

	int[] weights = new int[N];
	for (int i = 0; i < N; i++) weights[i] = 1;

	for (int i = 0; i < N; i++) {
	    Bag<Integer> nbrs = new Bag<Integer>();
	    for (int j = 0; j < k; j++) 
		nbrs.add(StdRandom.discrete(weights));
	    for (int v : nbrs) {
		G.addEdge(i, v);
		weights[v] = W * G.indegree(v) + 1;
	    }
	}

	for (int i = 0; i < N; i++) {
	    StdOut.print(i);
	    for (int j : G.adj(i))
		StdOut.print(" " + j);
	    StdOut.println();
	}
    }
    
}
