/******************************************************************************
 *
 * MAC0110 - Introdução à Computação
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Variante do Web Exercise 2.3.51 (Unix diff)
 * Data: 13/06/2017
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

public class DiffLines {

    public static void main(String[] args) {


        String[] x = StdIn.readAllLines();
        String texto1 = x[0];
        String texto2 = x[1];
        String[] palavras1 = texto1.split("\\s+");
        String[] palavras2 = texto2.split("\\s+");
        int tamanho1 = palavras1.length;
        int tamanho2 = palavras2.length;

        int[][] opt = new int[tamanho1+1][tamanho2+1];

        for (int i = tamanho1-1; i >= 0; i--) {
            for (int j = tamanho2-1; j >= 0; j--) {
                if (palavras1[i].equals(palavras2[j]))
                    opt[i][j] = opt[i+1][j+1] + 1;
                else 
                    opt[i][j] = Math.max(opt[i+1][j], opt[i][j+1]);
            }
        }

        int i = 0, j = 0;
        while (i < tamanho1 && j < tamanho2) {
            if (palavras1[i].equals(palavras2[j])) {
                i++;
                j++;
            }
            else if (opt[i+1][j] >= opt[i][j+1]) {
                palavras1[i] = "*" + palavras1[i] + "*";
                i++;
            }
            else {
                palavras2[j] = "*" + palavras2[j] + "*";
                j++;
            }
        }

        while (i < tamanho1 || j < tamanho2) {
            if (i == tamanho1) {
                palavras2[j] = "*" + palavras2[j] + "*";
                j++;
            }
            else if (j == tamanho2) {
                palavras1[i] = "*" + palavras1[i] + "*";
                i++;
            }
        }

        StdOut.println("First Line:");
        for (int k = 0; k < palavras1.length; k++) {
            StdOut.print(palavras1[k] + " ");
        }

        StdOut.println();
        StdOut.println("Second Line:");
        for (int k = 0; k < palavras2.length; k++) {
            StdOut.print(palavras2[k] + " ");
        }
    }

}