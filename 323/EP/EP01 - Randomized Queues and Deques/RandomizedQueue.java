import java.util.Iterator;
import java.util.NoSuchElementException;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdRandom;

public class RandomizedQueue<Item> implements Iterable<Item> {
	private Item[] q;       // queue elements
    private int n;          // number of elements on queue
    private int first;      // index of first element of queue
    private int last;       // index of next available slot

  	public RandomizedQueue() {
  		size = 2
  		q = (Item[]) new Object[size];
  		n = 0;
  		//first = 0;
  		//last = 0;
   	}                // construct an empty randomized queue

   	public boolean isEmpty() {
   		return n==0;
   	}                // is the randomized queue empty?

   	public int size() {
   		return n;
   	}                       // return the number of items on the randomized queue

   	public void enqueue(Item item) {
   		if(item == null) throw new IllegalArgumentException();
   		if (n >= size) {
   			size = size*2;
   			Item[] qNew = (Item[]) new Object[size];
   			for(int i = 0; i < n; i++) {
   				qNew[i] = q[i];
   			}
   			q = qNew;
   		}
   		q[n] = item;
   		n++
   	}          // add the item

   	public Item dequeue() {
   		if(n == 0) throw new NoSuchElementException();
   		int random = StdRandom.uniform(n);
   		Item dequeued = q[random];
   		q[random] = q[n-1];
   		q[n-1] = null;
   		n--;
   		if (n < size/4) {
   			size = size/2;
   			Item[] qNew = (Item[]) new Object[size];
   			for(int i = 0; i < n; i++) {
   				qNew[i] = q[i];
   			}
   			q = qNew;
   		}
   		return dequeued;
   	}                   // remove and return a random item

   	public Item sample() {
   		if(n == 0) throw new NoSuchElementException();
   		int random = StdRandom.uniform(n);
   		Item sampled = q[random];
   		return sampled;
   	}                    // return a random item (but do not remove it)

   	public Iterator<Item> iterator() {return new ListIterator();}

	private class ListIterator implements Iterator<Item> {
		private int count = 0;

		public boolean hasNext(){return !(count >= n);}

		public void remove() {throw new UnsupportedOperationException();}

		public Item next() {
			if (!hasNext()) throw new NoSuchElementException();
			Item iterated = q[count];
			count = count + 1;
			return iterated;
		}
	}        // return an independent iterator over items in random order

   	public static void main(String[] args) {

   	}   // unit testing (required)
}