public class Permutation {

   	public static void main(String[] args) {

   		int k = Integer.parseInt(args[0]);
   		int count = 0;
   		String text = StdIn.readString();
   		String[] words = text.split("\\s+");

   		RandomizedQueue<String> q = new RandomizedQueue<String>();
   		for (int i = 0; i < words.length; i++) {
   			q.enqueue(words[i]);
   		}
   		for(String s : q) {
   			if (count < k) {
   				StdOut.println(s);
   				count++;
   			}
		}
   	}
}