/*
 * $ java-introcs ChooseWords 50 < DATA/Gutenberg/Braz_Cubas.txt > 50.in
 * $ java-introcs ChooseWords 5000 < DATA/Gutenberg/Braz_Cubas.txt > 5000.in
 * 
 * https://www.ime.usp.br/~yoshi/DATA/Gutenberg/Braz_Cubas.txt
 */

public class ChooseWords {

    private enum State { OUT, IN }

    public static void main(String[] args) {
	int k = Integer.parseInt(args[0]);
	String s = StdIn.readAll();

	BST<String, Integer> words = new BST<String, Integer>();

	// we implement a simple automaton below; could also do something like
	// String[] w = s.split("[^\\p{L}]+");
	// and then add the words in w into the BST words
	// see https://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html

	StringBuilder current_word = new StringBuilder("");
	State state = State.OUT;
	for (int i = 0; i < s.length(); i++) {
	    char c = s.charAt(i);
	    switch (state) {
	    case OUT: 
		if (Character.isLetter(c)) {
		    current_word.append(c);
		    state = State.IN;
		}
		break;
	    case IN: 
		if (!Character.isLetter(c)) {
		    words.put(current_word.toString(), 0);
		    current_word = new StringBuilder("");
		    state = State.OUT; 
		} else
		    current_word.append(c);
		break;
	    }
	}
	if (state == State.IN)
	    words.put(current_word.toString(), 0);

	int N = words.size();
	SET<String> k_words = new SET<String>();
	while (k_words.size() < k) {
	    int i = StdRandom.uniform(N);
	    String w = words.select(i);
	    if (!k_words.contains(w)) k_words.add(w);
	}

	for (String w : k_words) StdOut.println(w);
    }

}
