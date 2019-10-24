import edu.princeton.cs.algs4.RectHV;
import edu.princeton.cs.algs4.Point2D;
import edu.princeton.cs.algs4.Queue;
import edu.princeton.cs.algs4.Stack;
import edu.princeton.cs.algs4.RedBlackBST;
import java.util.Iterator;

public class PointST<Value> {
   
	private RedBlackBST<Point2D, Value> tree;
   
	public PointST() {                            // construct an empty symbol table of points 
		tree = new RedBlackBST<Point2D, Value>();
	}

	public boolean isEmpty() {                  // is the symbol table empty? 
		return tree.isEmpty();
	}

	public int size() {                     // number of points 
		return tree.size();
	}

	public void put(Point2D p, Value val) {  // associate the value val with point p
		if (p == null || val == null) throw new IllegalArgumentException("Wrong argument");
		tree.put(p, val);
		return;
	}

	public Value get(Point2D p) {             // value associated with point p 
		if (p == null) throw new IllegalArgumentException("Wrong argument");
		return tree.get(p);
	}

	public boolean contains(Point2D p) {        // does the symbol table contain point p? 
		if (p == null) throw new IllegalArgumentException("Wrong argument");
		return tree.contains(p);
	}

	public Iterable<Point2D> points() {                   // all points in the symbol table 
		Stack<Point2D> stack1 = new Stack<Point2D>();
		return tree.keys();
	}

	public Iterable<Point2D> range(RectHV rect) {         // all points that are inside the rectangle (or on the boundary)
		if (rect == null) throw new IllegalArgumentException("Wrong argument"); 
		Queue<Point2D> queueR = new Queue<Point2D>();
		for (Point2D turn : this.points()) {
			if (rect.contains(turn))
				queueR.enqueue(turn);
		}		
		return queueR;
	}

	public Point2D nearest(Point2D p) {         // a nearest neighbor of point p; null if the symbol table is empty 
		if (p == null) throw new IllegalArgumentException("Wrong argument");
		if (this.isEmpty()) return null;
		for (Point2D poi : this.nearest(p, 1)) {
			p = poi;
		}
		return p;
	}

	public Iterable<Point2D> nearest(Point2D p, int i) {         // a nearest neighbor of point p; null if the symbol table is empty 
		if (i > this.size()) throw new IllegalArgumentException("Wrong argument");
		Queue<Point2D> queueN = new Queue<Point2D>();
		double nearD = 0;
		Point2D nearP = null;
		//for (int j = 0; j < i; j++) {
			for (Point2D turn : tree.keys()) {
				if (nearP == null) {
					nearD = turn.distanceSquaredTo(p);
					nearP = turn;
				}
				else if (turn.distanceSquaredTo(p) < nearD) {
					nearD = turn.distanceSquaredTo(p);
					nearP = turn;
				}
			}
			queueN.enqueue(nearP);
			for (int j = 0; j < i-1; j++) {
				nearP = tree.ceiling(nearP);
				queueN.enqueue(nearP);
			}
		//}
		return queueN;
	}

	public static void main(String[] args) {              // unit testing (required)
	}
}