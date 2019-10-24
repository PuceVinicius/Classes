import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;
import edu.princeton.cs.algs4.WeightedQuickUnionUF;
import edu.princeton.cs.algs4.In;

public class Percolation {
    
    private int maxSize;
    private int size;
    private WeightedQuickUnionUF uF;
    private static int[] blocked;
    private int openNumb;
    
    // creates n-by-n grid, with all sites initially blocked
    public Percolation(int n) {
        if (n < 1) throw new IllegalArgumentException("Wrong argument");
        maxSize = 10*10;
        size = 10;
        uF = new WeightedQuickUnionUF(maxSize);
        blocked = new int[maxSize];
        for (int i = 0; i < maxSize; i++) {
            blocked[i] = 0;
        }
        openNumb = 0;
    }

    public int blockedT(int row, int col) {
        int transformed = size*row + col;
        return blocked[transformed];
    }

    // opens the site (row, col) if it is not open already
    public void open(int row, int col) {
        int transformed = size*row + col;
        if (transformed < 0 || transformed > maxSize - 1) throw new IllegalArgumentException("Wrong argument");
        if (blocked[transformed] == 0) {
            blocked[transformed] = 1;
            if (transformed > size-1 && blocked[transformed - size] != 0) {
                uF.union(transformed - size, transformed);
                System.out.println(row + " "+ col + " " + "1");
            }
            if (transformed < maxSize/size - size && blocked[transformed + size] != 0) {
                uF.union(transformed + size, transformed);
                System.out.println(row + " "+ col + " " + "2");
            }
            if ((transformed%size) != 0 && blocked[transformed - 1] != 0) {
                uF.union(transformed - 1, transformed);
                System.out.println(row + " "+ col + " " + "3");
            }
            if ((transformed%size) != size-1 && blocked[transformed + 1] != 0) {
                uF.union(transformed + 1, transformed);
                System.out.println(row + " "+ col + " " + "4");
            }
            openNumb++;
        }
        return;
    }

    // is the site (row, col) open?
    public boolean isOpen(int row, int col) {
        int transformed = size*row + col;
        if (transformed < 0 || transformed > maxSize - 1) throw new IllegalArgumentException("Wrong argument");
        return blocked[transformed] != 0;
    }

    // is the site (row, col) full?
    public boolean isFull(int row, int col) {
        int transformed = size*row + col;
        //System.out.println(row);
        //System.out.println(transformed);
        //System.out.println(maxSize);
        if ((transformed < 0) || (transformed > maxSize - 1)) throw new IllegalArgumentException("Wrong argument");
        boolean full = false;
        if (isOpen(row, col)) {
            System.out.println(row + " " + col + " " + uF.find(transformed));
            if (uF.find(transformed) < size) full = true;
        }
        return full;
    }

    // returns the number of open sites
    public int numberOfOpenSites() {
        return openNumb;
    }

    // does the system percolate?
    public boolean percolates() {
        boolean percol = false;
        for (int i = 0; i < size; i++) {
            if (isFull(maxSize/size - 1, i)) percol = true;
            if (percol) System.out.println("ola"+(maxSize/size - 1) + " " + i);
        }
        if (size == 1) percol = true;
        return percol;
    }

    // unit testing (required)
    public static void main(String[] args) {
        Percolation percolation = new Percolation(10);
        /*for (int i = 0; i < 10; i++) {
            percolation.open(0,i);
            System.out.println(i);
        }
        if (percolation.percolates()) {
            System.out.println("rola");
        }*/

        String filename = args[0];
        In in = new In(filename);

        while (!in.isEmpty()) {
            int row = in.readInt();
            int col = in.readInt();
            percolation.open(row, col);
        }

        for(int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
                int transformed = 10*i + j;
                System.out.print(blocked[transformed]);
            }
            System.out.println();
        }
        System.out.println();
        System.out.println();
        System.out.println();
        if(percolation.percolates()) {
            System.out.println("rola");
        }
    }
}