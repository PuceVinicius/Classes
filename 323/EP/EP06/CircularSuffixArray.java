import edu.princeton.cs.algs4.StdOut;
import java.util.Arrays;
import java.util.Comparator;

public class CircularSuffixArray {

	private String base;
	private Integer[] index;

   	public CircularSuffixArray(String s) {   // circular suffix array of s 
   		if (s == null) throw new IllegalArgumentException("Wrong argument");

   		base = s;
   		index = new Integer[s.length()];
   		for (int i = 0; i < s.length(); i++) index[i] = i; //inicia o vetor index

      	Arrays.sort(index, new Comparator<Integer>() {
         	@Override
         	public int compare(Integer a, Integer b) {
            	int baseA = a.intValue(); 
         		int baseB = b.intValue(); 
            	for (int i = 0; i < base.length(); i++) {     //itera a string inteira
	            	if (a > base.length() - 1) baseA = 0; // caso algum valor ultrapasse o tamanho
	            	if (b > base.length() - 1) baseB = 0; // da string, ele volta pro inicio
	            	if (base.charAt(baseA) > base.charAt(baseB)) return 1;  //compara string com sufixo a com
	            	if (base.charAt(baseA) < base.charAt(baseB)) return -1;	//a string de sufixo b
	            	baseA++;
	            	baseB++;
	            }
	            return 0; //string iguais
	        }
	    });
   	}

   	public int length() {                    // length of s
   		return base.length();
   	}

   	public int index(int i) {                // returns index of ith sorted suffix
   		if (i < 0 || i > base.length() - 1) throw new IllegalArgumentException("Wrong argument");
   		return index[i];
   	}

   	public static void main(String[] args) { // unit testing (required)
   		CircularSuffixArray c = new CircularSuffixArray("ABRACADABRA!");
   		for (int i = 0; i < 12; i++)
   			StdOut.println(c.index(i));
   	}
}