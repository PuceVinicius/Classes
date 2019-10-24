import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.BinaryStdOut;
import edu.princeton.cs.algs4.BinaryStdIn;

public class MoveToFront {
    // apply move-to-front encoding, reading from standard input and writing to standard output
    private static int ascii = 256;

    public static void encode() {

        //cria o alphabet
        char[] alphabet = new char[ascii];
    	for (int i = 0; i < ascii; i++) alphabet[i] = (char) i;

        String s = BinaryStdIn.readString();

        int j = 0;
        for (int i = 0; i < s.length(); i++) {
            j = 0;
            while (s.charAt(i) != alphabet[j]) j++; //itera ate achar encontrar o char em alphabet
            BinaryStdOut.write(j, 8);
            //atualiza o alphabet com base no char de entrada
            for (int k = j; k > 0; k--) alphabet[k] = alphabet[k-1];
            alphabet[0] = s.charAt(i);
        }

        BinaryStdOut.close();
    }

    // apply move-to-front decoding, reading from standard input and writing to standard output
    public static void decode() {

        //cria o alphabet
        char[] alphabet = new char[ascii];
        for (int i = 0; i < ascii; i++) alphabet[i] = (char) i;


        while (!BinaryStdIn.isEmpty()) {
            //transforma os bits de entrada em int
            int c = (int) BinaryStdIn.readChar();
            BinaryStdOut.write(alphabet[c], 8);
            char dedo = alphabet[c];
            //atualiza o alphabet com base nos bits de entrada
            for (int k = c; k > 0; k--) alphabet[k] = alphabet[k-1];
            alphabet[0] = dedo;
        }

        BinaryStdOut.close();
    }

    // if args[0] is '-', apply move-to-front encoding
    // if args[0] is '+', apply move-to-front decoding
    public static void main(String[] args) {
        char base1 = args[0].charAt(0);

        if      (base1 == '-') encode();
        else if (base1 == '+') decode();
        else throw new IllegalArgumentException("Illegal command line argument");
    }
}