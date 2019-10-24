/******************************************************************************
 *
 * MAC0110 - Introdução à Computação
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Ex. 9 ((a, b)-permutações)
 * Data: 03/06/2017
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

public class ABPerms {


	public  static int perm1(String prefix, String sequencia, int[] decres, int[] cres, int a, int b, int m) {

        int s = 0;
        int tamanhoS = sequencia.length();
        if (tamanhoS == 0) {
            if (m == 0 || m == 2) {
                StdOut.println(prefix);
            }
        	return 1;
        }
        for (int i = 0; i < tamanhoS; i++) {
            char charS = sequencia.charAt(i);
            int tamanhoP = prefix.length();

            decres[tamanhoP] = 0;
            cres[tamanhoP] = 0;

            int maxDecres = 0;
            int maxCres = 0;
            for (int j = 0; j < tamanhoP; j++) {
                if (charS > prefix.charAt(j) && decres[tamanhoP] < decres[tamanhoP]) {
                    decres[tamanhoP] = decres[tamanhoP];
                }
                if (charS < prefix.charAt(j) && cres[tamanhoP] < cres[tamanhoP]) {
                    cres[tamanhoP] = cres[tamanhoP];
                }
                if (maxDecres < decres[tamanhoP]) {
                    maxDecres = decres[tamanhoP];
                }
                if (maxCres < cres[tamanhoP]) {
                    maxCres = cres[tamanhoP];
                }
            }
            decres[tamanhoP] = decres[tamanhoP] + 1;
            cres[tamanhoP] = cres[tamanhoP] + 1;
            if (maxDecres < decres[tamanhoP]) {
                maxDecres = decres[tamanhoP];
            }
            if (maxCres < cres[tamanhoP]) {
                maxCres = cres[tamanhoP];
            }

            if (maxDecres <= a && maxCres <= b) {
               s = s + perm1(prefix + charS, sequencia.substring(0, i) + sequencia.substring(i+1, tamanhoS), decres, cres, a, b, m);
            }   
        }
        return s;
    }

    public static void main (String[] args) {

        int n = Integer.parseInt(args[0]);
        int a = Integer.parseInt(args[1]);
        int b = Integer.parseInt(args[2]);
        int m = StdIn.readInt();
        int x = 0;
    	String prefix = "";
        int[] decres = new int[n + 1];
        int[] cres = new int[n + 1];
        String alpha = "abcdefghijklmnopqrstuvwxyz";
        String correto = "";
        for (int i = 0; i < n; i++) {
            correto = correto + alpha.charAt(i);
        }

        if (m >= 1) {
	       x = perm1(prefix, correto, decres, cres, a, b, m);
           StdOut.println();
           StdOut.println(x);
        }
        else perm1(prefix, correto, decres, cres, a, b, m);
    }
}