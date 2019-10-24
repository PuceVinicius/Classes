public class CircularSuffixArray {

	private int size;
	private int[] index;

   	public CircularSuffixArray(String s) {   // circular suffix array of s 
   		index = new int[s.length];
   		String suffixes = new String[s.length];
   		String suffixesS = new String[s.length];
   		String circ;

   		for (int i = 0; i < s.length; i++) {
   			circ = s.substring(0, i+1);
   			suffixes[i] = s.substring(i, s.length) + circ;
   		}

   		suffixesS = suffixes;
   		Quick.sort(suffixesS);
   		for (int i = 0; i < s.length; i++) {
   			for (int j = 0; j < s.length; j++) {
   				if (suffixes[i] == suffixesS[j]) index[j] = i;
   			}
   		}
   	}

   	public int length() {                    // length of s
   		return size;
   	}

   	public int index(int i) {                // returns index of ith sorted suffix
   		return index[i];
   	}

   	public static void main(String[] args) { // unit testing (required)
   		CircularSuffixArray c = CircularSuffixArray("ABRACADABRA!");
   		StdOut.println(c.index(11));
   	}
}