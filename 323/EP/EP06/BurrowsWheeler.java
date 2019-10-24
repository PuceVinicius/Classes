import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.BinaryStdOut;
import edu.princeton.cs.algs4.BinaryStdIn;
import edu.princeton.cs.algs4.StdOut;

public class BurrowsWheeler {
    // apply Burrows-Wheeler transform, reading from standard input and writing to standard output
    public static void transform() {
    	int firstE = 0;

        String s = BinaryStdIn.readString();

        CircularSuffixArray c = new CircularSuffixArray(s);

        String sFinal = "";
        for (int i = 0; i < s.length(); i++) {
            if (c.index(i) == 0) firstE = i; //encontra o inicio dos sufixos ordenados
            //utiliza o index do CircularSuffixArray para achar o ultimo char
            sFinal += s.charAt((c.index(i) + s.length() - 1) % s.length());
        }

        BinaryStdOut.write(firstE);
        BinaryStdOut.write(sFinal);

        BinaryStdOut.close();
    }

    // apply Burrows-Wheeler inverse transform, reading from standard input and writing to standard output
    public static void inverseTransform() {
        StdOut.println("Funcao inverseTransform nao foi implementada hihi");
    }

    // if args[0] is '-', apply Burrows-Wheeler transform
    // if args[0] is '+', apply Burrows-Wheeler inverse transform
    public static void main(String[] args) {

        char base1 = args[0].charAt(0);

        if      (base1 == '-') transform();
        else if (base1 == '+') inverseTransform();
        else throw new IllegalArgumentException("Illegal command line argument");
    }
}