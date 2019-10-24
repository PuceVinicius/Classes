import java.util.Iterator;
import java.util.NoSuchElementException;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.StdIn;

public class Deque<Item> implements Iterable<Item> {

	private static class Node <Item> {
		private Item item;
		private Node<Item> next;
		private Node<Item> previous;
	}

	private Node<Item> first;
	private int n;
	private Node<Item> last;

	public Deque() {
		first = null;
		last = null;
		n = 0;
	}
	public boolean isEmpty() {
		return size()==0;
	}

	public int size() {
		return n;
	}

	public void addFirst(Item item) {
		if(item == null) throw new IllegalArgumentException("Null argument");
		Node newFirst = new Node();
		newFirst.item = item;
		if(isEmpty()) {
			first = newFirst;
			last = newFirst;
			n++;
		}
		else {
			newFirst.next = first;
			first.previous = newFirst;
			first = newFirst;
			n++;
		}
	}

	public void addLast(Item item) {
		if(item == null) throw new IllegalArgumentException("Null argument");
		Node newLast = new Node();
		newLast.item = item;
		if(isEmpty()) {
			first = newLast;
			last = newLast;
			n++;
		}
		else {
			last.next = newLast;
			newLast.previous = last;
			last = newLast;
			n++;
		}
	}

	public Item removeFirst() {
		if(isEmpty()) throw new NoSuchElementException("Empty deque");
		Item removed = first.item;
		if(n == 1){
      		first = null;
      		last = null;
      		n--;
      		return removed;
    	}
		first = first.next;
		first.previous = null;
		n--;
		return removed;
	}

	public Item removeLast() {
		if(isEmpty()) throw new NoSuchElementException("Empty deque");
		Item removed = last.item;
		last = last.previous;
		last.next = null;
		n--;
		return removed;
	}

	public Iterator<Item> iterator() {return new ListIterator();}

	private class ListIterator implements Iterator<Item> {
		private Node<Item> index = first;

		public boolean hasNext(){return index != null;}

		public void remove() {throw new UnsupportedOperationException();}

		public Item next() {
			if (!hasNext()) throw new NoSuchElementException();
			Item iterated = index.item;
			index = index.next;
			return iterated;
		}
	}

	public static void main (String[] args) {

	}
}