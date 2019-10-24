import edu.princeton.cs.algs4.Picture;
import java.awt.Color;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.MinPQ;

public class SeamCarver {

	private Picture pictureA;
	private double[][] distTo;
	private int[][] prev;
	private double[][] energy2d;


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

		//trocando para os indices de uma matriz real
		int exch = x;
		x = y;
		y = exch;

		if (x < 0 || x > pictureA.width() - 1)
			throw new IllegalArgumentException("x out of bounds");
		if (y < 0 || y > pictureA.height() - 1)
			throw new IllegalArgumentException("y out of bounds");

		double xEnergy = 0.0;
		double yEnergy = 0.0;


		//As condicoes sao para os casos em que quer-se calcular a energia de um
		//ponto que se encontra em pelo menos uma das extremidades da figura
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
		int[] horizontal = new int[pictureA.width()];

		//Calcula a matriz transposta e transforma a imagem, salvando a original
		Picture pictureO = pictureA;
		Picture pictureT = new Picture(pictureO.height(), pictureO.width());

		for (int i = 0; i < pictureT.width(); i++) {
			for (int j = 0; j < pictureT.height(); j++) {
				pictureT.set(i, j, pictureO.get(j, i));
			}
		}

		pictureA = pictureT;

		horizontal = findVerticalSeam();

		//Volta para a imagem original
		pictureA = pictureO;

		return horizontal;
	}
	public   int[] findVerticalSeam() {                // sequence of indices for vertical seam

		//saida da função
		int[] vertical = new int[pictureA.height()];

		//matriz das distancias
		distTo = new double[pictureA.height()][pictureA.width()];

		//matriz do vertice anterior
		prev = new int[pictureA.height()][pictureA.width()];

		//matriz das energias
		energy2d = new double[pictureA.height()][pictureA.width()];
		for (int i = 0; i < pictureA.height(); i++) {
			for (int j = 0; j < pictureA.width(); j++) {
				energy2d[i][j] = energy(i, j);
				if (i == 0) prev[i][j] = j;
				else prev[i][j] = -1;
				if (i == 0) distTo[i][j] = energy2d[i][j];
				else distTo[i][j] = Double.POSITIVE_INFINITY;
				//StdOut.print(distTo[i][j]+" ");
			}
			//StdOut.println();
		}

		for (int i = 0; i < pictureA.height()-1; i++) {
			for (int j = 0; j < pictureA.width(); j++) {
				//i+1, j-1
				comparation(i, j, i+1, j-1);
				//i+1, j
				comparation(i, j, i+1, j);
				//i+1, j+1
				comparation(i, j, i+1, j+1);
				//StdOut.print(a+" ");
			}
			//StdOut.println();
		}

		double lowest = Double.POSITIVE_INFINITY;
		int lowIndex = -1;
		for (int i = 0; i < pictureA.width(); i++) {
			if(distTo[pictureA.height()-1][i] < lowest) {
				lowest = distTo[pictureA.height()-1][i];
				lowIndex = i;
			}
		}

		vertical[pictureA.height()-1] = lowIndex;
		for (int i = pictureA.height()-2; i >= 0; i--) {
			vertical[i] = prev[i+1][vertical[i+1]];
			//StdOut.print(vertical[i] + " ");
			//StdOut.println();
		}

		for (int i = 0; i < pictureA.height(); i++) {
			for (int j = 0; j < pictureA.width(); j++) {
				//StdOut.print(prev[i][j] + " ");
			}
			//StdOut.println();
		}

		return vertical;
	}
	public    void removeHorizontalSeam(int[] seam) {  // remove horizontal seam from current picture
		if (seam == null)
			throw new IllegalArgumentException("seam null");

		if (seam.length != width())
			throw new IllegalArgumentException("wrong seam");

		//Calcula a matriz transposta e transforma a imagem
		Picture pictureT = new Picture(pictureA.height(), pictureA.width());

		for (int i = 0; i < pictureT.width(); i++) {
			for (int j = 0; j < pictureT.height(); j++) {
				pictureT.set(i, j, pictureA.get(j, i));
			}
		}

		pictureA = pictureT;

		removeVerticalSeam(seam);

		//Retranspõe
		pictureT = new Picture(pictureA.height(), pictureA.width());

		for (int i = 0; i < pictureT.width(); i++) {
			for (int j = 0; j < pictureT.height(); j++) {
				pictureT.set(i, j, pictureA.get(j, i));
			}
		}

		return;
	}
	public    void removeVerticalSeam(int[] seam) {    // remove vertical seam from current picture 
		if (seam == null)
			throw new IllegalArgumentException("seam null");

		if (seam.length != height())
			throw new IllegalArgumentException("wrong seam");

		//cria uma nova picture com uma coluna a menos
		Picture pictureNew = new Picture(pictureA.width()-1, pictureA.height());

		//ignora as casas de seam[]
		for (int i = 0; i < pictureNew.height(); i++) {
			for (int j = 0; j < seam[i]; j++) {
				pictureNew.set(j, i, pictureA.get(j, i));
				//StdOut.print(pictureA.get(j, i) + " ");
			}
			for (int j = seam[i]; j < pictureNew.width(); j++) {
				pictureNew.set(j, i, pictureA.get(j + 1, i));
				//StdOut.print(pictureA.get(j + 1, i) + " ");
			}
			//StdOut.println();
		}

		pictureA = pictureNew;

		return;
	}
	private void comparation(int x, int y, int a, int b) {
		if (b == -1) b = pictureA.width() - 1;
		if (b == pictureA.width()) b = 0;  
		if (distTo[x][y] + energy2d[a][b] < distTo[a][b]) {
			distTo[a][b] = distTo[x][y] + energy2d[a][b];
			prev[a][b] = y;
		}
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
		for (int i = 0; i < seam.height(); i++) {
			for (int j = 0; j < seam.width(); j++) {
				StdOut.print(seam.energy(i, j) + " ");
			}
			StdOut.println();
		}
		int[] teste = seam.findHorizontalSeam();
		seam.removeHorizontalSeam(teste);
			StdOut.println();
			StdOut.println();
		for (int i = 0; i < seam.height(); i++) {
			for (int j = 0; j < seam.width(); j++) {
				StdOut.print(seam.energy(i, j) + " ");
			}
			StdOut.println();
		}
		/*for (int i = 0; i < seam.width(); i++)
			StdOut.print(teste[i] + "-");*/
	}
}