/******************************************************************************
 *  Compilation:  javac VisualAccumulator.java
 *  Execution:  none
 *  Dependencies: StdDraw.java
 *
 *  Visual accumulator mutable data type (variant).
 *
 ******************************************************************************/


public class VisualAccumulator {
    private double total;
    private int n;
    private int W;

    // W is the window's width; max is the window's height
    public VisualAccumulator(double max, int W) {
	this.W = W;
        StdDraw.setXscale(0, W);
        StdDraw.setYscale(0, max);
        StdDraw.setPenRadius(0.005);
    }

    // trials is the window's width
    public VisualAccumulator(int trials, double max) {
	this(max, trials);
    }

    public void addDataValue(double value) {
        n++;
        total += value;
        StdDraw.setPenColor(StdDraw.DARK_GRAY);
	int x = n % W;
	if (x == 0) StdDraw.clear(); // wrap around after every W datapoints
        StdDraw.point(x, value);
        StdDraw.setPenColor(StdDraw.RED);
        StdDraw.point(x, mean());
    }

    public double mean() {
        return total / n;
    }

    public String toString() {
        return "Mean (" + n + " values): " + String.format("%8.5f", mean());
    }
}
