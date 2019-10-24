/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Tarefa: Non-overlapping interval search
 * Data: 06/11/2017
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/
import java.util.Arrays;

public class MWS {

    //essa busca binaria poderia ser void, mas por algum motivo meu codigo
    //nao funciona, passei a madrugada inteira morrendo, obrigado.

    public static String indexOfpos(String[] a, int[] b, String key, int[] c) {
        int lo = 0;
        int hi = a.length - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if      (key.compareTo(a[mid]) < 0) hi = mid - 1;
            else if (key.compareTo(a[mid]) > 0) lo = mid + 1;
            else {
                if (b[mid] == 0) {
                    c[0]++;
                }
                b[mid]++;
                return a[mid];
            }
        }
        return "";
    }

    public static String indexOfneg(String[] a, int[] b, String key, int[] c) {
        int lo = 0;
        int hi = a.length - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if      (key.compareTo(a[mid]) < 0) hi = mid - 1;
            else if (key.compareTo(a[mid]) > 0) lo = mid + 1;
            else {
                b[mid]--;
                if (b[mid] == 0) {
                    c[0]--;
                }
                return a[mid];
            }
        }
        return "";
    }

    public static void main(String[] args) {
        
        In textB = new In(args[0]);
        String[] text = textB.readAllStrings();
        In wordsB = new In(args[1]);
        String[] words = wordsB.readAllStrings();

        int[] wordCount = new int[words.length];

        Arrays.sort(words);

        int p1i = 0;
        int p2i = 0;

        int fix1i = 0;

        int minDiff = 0;
        int diff0 = 0;

        int[] contador = new int[1];
        boolean cond = true;

        String amizade = "";

        while (cond) {

        StdOut.println(contador[0] + "" + words.length);

            //contar palavras da linha e troca o j
            if (contador[0] == words.length) {
                amizade = indexOfneg(words, wordCount, text[p1i], contador);
                if (contador[0] == words.length) {
                    diff0 = p2i - p1i;
                    if (minDiff == 0) minDiff = diff0;
                    if (minDiff > diff0) minDiff = diff0;
                }
                p1i++;
            }
            else {
                amizade = indexOfpos(words, wordCount, text[p1i], contador);
                if (contador[0] == words.length) {
                    diff0 = p2i - p1i;
                    if (minDiff == 0) minDiff = diff0;
                    if (minDiff > diff0) minDiff = diff0;
                }
                if (p2i == words.length-1) {
                    cond = false;
                }
                p2i++;
            }
        }
        StdOut.println(minDiff);
    }
}










