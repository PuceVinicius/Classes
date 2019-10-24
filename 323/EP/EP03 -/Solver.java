import java.util.Iterator;
import edu.princeton.cs.algs4.MinPQ;
import edu.princeton.cs.algs4.Stack;
import edu.princeton.cs.algs4.StdOut;

public class Solver {

    private SearchNode result;
    private Board start;
    
    private static class SearchNode implements Comparable<SearchNode> {
        private Board board;
        private int moves;
        private int priority;
        private SearchNode prev;

        public int compareTo(SearchNode that) {
            if(this.priority > that.priority){
                return 1;
            }

            else if (this.priority < that.priority){
                return -1;
            }

            else{
                return 0;
            }
        }
    }

    public Solver(Board initial) { // find a solution to the initial board (using the A* algorithm)
        if (initial == null) throw new java.lang.IllegalArgumentException("Wrong Argument");
        if (!initial.isSolvable()) throw new java.lang.IllegalArgumentException("Unsolvable puzzle");
        
        start = initial;
        
        MinPQ<SearchNode> queue = new MinPQ<SearchNode>();

        SearchNode initialS = new SearchNode();
        initialS.board = initial;
        initialS.moves = 0;
        initialS.prev = null;
        initialS.priority = 0;
        queue.insert(initialS);

        boolean goal = false;

        while (!queue.isEmpty() && !goal) {

            SearchNode base = queue.delMin();

            if (base.board.isGoal()) {
                result = base;
                goal = true;
                //StdOut.println(base.moves());
            }
            else {
                for (Board current : base.board.neighbors()) {
                    if (base.prev != null) {
                        if (current != base.prev.board) {
                            SearchNode neigh = new SearchNode();
                            neigh.board = current;
                            neigh.moves = base.moves + 1;
                            neigh.prev = base;
                            neigh.priority = neigh.moves + current.manhattanN();
                            queue.insert(neigh);
                        }
                    }
                    else {
                        SearchNode neigh = new SearchNode();
                        neigh.board = current;
                        neigh.moves = base.moves + 1;
                        neigh.prev = base;
                        neigh.priority = neigh.moves + current.manhattanN();
                        queue.insert(neigh);
                    }
                }
            }
        }
    }

    public int moves() { // min number of moves to solve initial board
        return result.moves;
    }

    public Iterable<Board> solution() { // sequence of boards in a shortest solution
        Stack<Board> stack = new Stack<Board>();
        while (result.prev != null) {
            stack.push(result.board);
            result = result.prev;
        }
        return stack;
    }
    
    public static void main(String[] args) { // test client (see below) 

        int[][] tiles = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 0}
        };
        Board bardo = new Board(tiles);
        Solver solvado = new Solver(bardo);
    }
}