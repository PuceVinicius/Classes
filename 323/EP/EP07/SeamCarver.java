import edu.princeton.cs.algs4.Picture;
import java.awt.Color;
import edu.princeton.cs.algs4.StdOut;

public class SeamCarver {

	private Picture pictureA;

	public SeamCarver(Picture picture) {               // create a seam carver object based on the given picture
		pictureA = new Picture(picture);
	}
	public Picture picture()  {                        // current picture
		return pictureA;
	}
	public     int width() {                           // width of current picture
		return pictureA.width();
	}
	public     int height() {                          // height of current picture
		return pictureA.height();
	}

	public  double energy(int x, int y)  {             // energy of pixel at column x and row y
		double xEnergy = 0.0;
		double yEnergy = 0.0;
		if(x == 0)
			xEnergy = power(pictureA.get(pictureA.width()-1, y), pictureA.get(x+1, y));
		else if (x == (pictureA.width()-1))
			xEnergy = power(pictureA.get(x-1, y), pictureA.get(0, y));
		else 
			xEnergy = power(pictureA.get(x-1, y), pictureA.get(x+1, y));
		if(y == 0)
			yEnergy = power(pictureA.get(x, pictureA.height()-1), pictureA.get(x, y+1));
		else if (y == (pictureA.height()-1))
			yEnergy = power(pictureA.get(x, y-1), pictureA.get(x, 0));
		else
			yEnergy = power(pictureA.get(x, y-1), pictureA.get(x, y+1));

		return Math.sqrt(xEnergy + yEnergy);
	}

	public   int[] findHorizontalSeam() {              // sequence of indices for horizontal seam
		int[] a = new int[3];
		return a;
	}
	public   int[] findVerticalSeam() {                // sequence of indices for vertical seam
		int[] a = new int[3];
		return a;
	}
	public    void removeHorizontalSeam(int[] seam) {  // remove horizontal seam from current picture
		return;
	}
	public    void removeVerticalSeam(int[] seam) {    // remove vertical seam from current picture 
		return;
	}
	private  double power(Color a, Color b) {
		double aR = a.getRed();
		double aG = a.getGreen();
		double aB = a.getBlue();
		double bR = b.getRed();
		double bG = b.getGreen();
		double bB = b.getBlue();
		double red = (aR - bR)*(aR - bR);
		double green = (aG - bG)*(aG - bG);
		double blue = (aB - bB)*(aB - bB);
		return red + green + blue;
	}
	public static void main(String[] args) {           //  unit testing (required)
		Picture rola = new Picture(args[0]);
		SeamCarver seam = new SeamCarver(rola);
		StdOut.println("height:" + seam.height());
		StdOut.println("width:" + seam.width());
	}
}