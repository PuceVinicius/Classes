import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;
import edu.princeton.cs.algs4.WeightedQuickUnionUF;

public class Percolation {
    
    private int maxSize;
    private int size;
    private WeightedQuickUnionUF uF;
    private int[] blocked;
    private int openNumb;
    
    // creates n-by-n grid, with all sites initially blocked
    public Percolation(int n) {
        maxSize = n*n;
        size = n;
        uF = new WeightedQuickUnionUF(maxSize);
        int[] blocked = new int[maxSize];
        for (int i = 0; i < maxSize; i++) {
            blocked[i] = 0;
        }
        openNumb = 0;
    }

    // opens the site (row, col) if it is not open already
    public void open(int row, int col) {
        int transformed = size*row + col;
        if (blocked[transformed] == 0) {
            blocked[transformed] = 1;
            if (transformed > size-1 || blocked[transformed - size] != 0)
                uF.union(transformed, transformed - size);
            if (transformed < maxSize - size || blocked[transformed + size] != 0)
                uF.union(transformed, transformed + size);
            if ((transformed%size) != 0 || blocked[transformed - 1] != 0)
                uF.union(transformed, transformed - 1);
            if ((transformed%size) != size-1 || blocked[transformed + 1] != 0)
                uF.union(transformed, transformed + 1);
        }
        openNumb++;
        return;
    }

    // is the site (row, col) open?
    public boolean isOpen(int row, int col) {
        int transformed = size*row + col;
        return blocked[transformed] != 0;
    }

    // is the site (row, col) full?
    public boolean isFull(int row, int col) {
        int transformed = size*row + col;
        boolean full = false;
        if (isOpen(row, col)) {
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
            if (isFull(maxSize-size, i)) percol = true;
        }
        return percol;
    }

    // unit testing (required)
    public static void main(String[] args) {

    }
}