import java.util.Iterator;
import edu.princeton.cs.algs4.MinPQ;
import edu.princeton.cs.algs4.Stack;
import edu.princeton.cs.algs4.StdOut;

public class Board {

    private int[][] board;     
    private int size;
    private int nulli;
    private int nullj;
    private int manha;

    public Board(int[][] tiles) { // create a board from an n-by-n array of tiles,
                                  // where tiles[row][col] = tile at (row, col)
        size = tiles.length;
        board = new int[size][size];
        for (int i = 0; i < size(); i++) {
            for (int j = 0; j < size(); j++) {
                board[i][j] = tiles[i][j];
                if (board[i][j] == 0) {
                    nulli = i;
                    nullj = j;
                }
            }
        }
        this.manha = this.manhattan();
    }
    public String toString() { // string representation of this board
        String transformed = size() + "\n";
        for (int i = 0; i < size(); i++) {
            for (int j = 0; j < size(); j++) {
                transformed += " " + board[i][j];
            }
            transformed += "\n";
        }
        return transformed;
    }

    public int tileAt(int row, int col) { // tile at (row, col) or 0 if blank
        if (row < 0 || row >= size()) throw new IllegalArgumentException("Wrong argument");
        if (col < 0 || col >= size()) throw new IllegalArgumentException("Wrong argument");
        return board[row][col];
    }

    public int size() { // board size n
        return size;
    }

    public int hamming() { // number of tiles out of place
        int hamm = 0;
        for (int i = 0; i < size(); i++) {
            for (int j = 0; j < size(); j++) {
                if (board[i][j] != (i*size() + j + 1)) {
                    hamm++;
                }
            }
        }
        return hamm - 1;
    }

    public int manhattanN() {
        return this.manha;
    }

    public int manhattan() { // sum of Manhattan distances between tiles and goal
        int manh = 0;
        int basei = 0;
        int basej = 0;
        for (int i = 0; i < size(); i++) {
            for (int j = 0; j < size(); j++) {
                if (board[i][j] != (i*size() + j + 1) && board[i][j] != 0) {
                    basei = (board[i][j]-1)/size();
                    basej = (board[i][j]-1)%size();
                    if (i - basei > 0) {manh += i - basei;}
                    else {manh += basei - i;}
                    if (j - basej > 0) {manh += j - basej;}
                    else {manh += basej - j;}
                    basei = 0;
                    basej = 0;
                }
            }
        }
        return manh;
    }

    public boolean isGoal() { // is this board the goal board?
        String compare1 = size() + "\n";
        int mark = 1;
        for (int i = 0; i < size(); i++) {
            for (int j = 0; j < size(); j++) {
                if (mark == size()*size()) mark = 0;
                compare1 += " " + mark;
                mark++;
            }
            compare1 += "\n";
        }
        String compare2 = this.toString();
        return compare1.equals(compare2);
    }

    public boolean equals(Object y) { // does this board equal y?
        if (y == this) return true;
        if (y == null) return false;
        if (y.getClass() != this.getClass()) return false;
        Board that = (Board) y;
        return (this.toString().equals(that.toString()));
    }

    public Iterable<Board> neighbors() { // all neighboring boards
        Stack<Board> stack = new Stack<Board>();
        if (nulli != 0) {
            this.swap(nulli, nullj, nulli - 1, nullj);
            Board neighbor = new Board(board);
            stack.push(neighbor);
            this.swap(nulli, nullj, nulli - 1, nullj);
        }
        if (nulli != size() - 1) {
            this.swap(nulli, nullj, nulli + 1, nullj);
            Board neighbor = new Board(board);
            stack.push(neighbor);
            this.swap(nulli, nullj, nulli + 1, nullj);
        }
        if (nullj != 0) {
            this.swap(nulli, nullj, nulli, nullj - 1);
            Board neighbor = new Board(board);
            stack.push(neighbor);
            this.swap(nulli, nullj, nulli, nullj - 1);
        }
        if (nullj != size() - 1) {
            this.swap(nulli, nullj, nulli, nullj + 1);
            Board neighbor = new Board(board);
            stack.push(neighbor);
            this.swap(nulli, nullj, nulli, nullj + 1);
        }
        return stack;
    }

    private void swap(int i1, int j1, int i2, int j2) {
        int temp = board[i1][j1];
        board[i1][j1] = board[i2][j2];
        board[i2][j2] = temp;
    }

    public boolean isSolvable() { // is this board solvable?
        String solve = "";
        int firstNum = 0;
        int secondNum = 0;
        int invertions = 0;

        for (int i = 0; i < size(); i++) {
            for (int j = 0; j < size(); j++) {
                for (int k = i*size() + j; k < size()*size(); k++) {
                    if (board[i][j] > board[k/size()][k%size()] && 
                        board[i][j] != 0 && board[k/size()][k%size()] != 0) {
                            invertions++;
                            //StdOut.println(i + " " + j + " - " + (k/size()) + " " + (k%size()) );
                    }
                }
            }
        }
        /*for (int i = 0; i < size(); i++) {
            for (int j = 0; j < size(); j++) {
                solve += board[i][j];
            }
        }
        for (int i = 0; i < solve.length(); i++) {
            for (int j = i; j < solve.length(); j++) {
                firstNum = Integer.parseInt(solve.substring(i, i+1));
                secondNum = Integer.parseInt(solve.substring(j, j+1));
                if (firstNum != 0 && secondNum != 0 && firstNum > secondNum) invertions++;
            }
        }*/
        //StdOut.println("invertions "+invertions);
        //StdOut.println(nullj);
        if (size()%2 == 1) {
            if (invertions%2 == 0) return true;
            else return false;
        }
        else {
            int total = nulli + invertions;
            if (total%2 == 1) return true;
            else return false; 
        }
    }
        
    public static void main(String[] args) { // unit testing (required)

        int[][] tiles = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 0}
        };
        Board bardo = new Board(tiles);
        for (Board disney : bardo.neighbors()) {
            StdOut.println(disney.toString());
        }
    }
} 