/******************************************************************************
 *
 * $ java-introcs HSB .0 1.0
 * $ java-introcs HSB .33 .67
 * $ java-introcs HSB .0 .33
 * $ java-introcs HSB .67 1.0
 * 
 ******************************************************************************/

import java.awt.Color;

public class HSB {  
    public static void main(String[] args) {
	float h1 = Float.parseFloat(args[0]);
	float h2 = Float.parseFloat(args[1]);
        StdDraw.setXscale(-2, 101);
        StdDraw.setYscale(-2, 2);
        for (int i = 0; i < 100; i++) {
	    	float t = i/99.0f;
	    	float h = (1-t)*h1 + t*h2;
	    	Color c = Color.getHSBColor(h, .95f, .95f);
	    	StdDraw.setPenColor(c);
	    	StdDraw.filledSquare(i, 0, 1);
        }
	StdDraw.save("strip" + "-" + h1 + "-" + h2 + ".png");
    }
}
