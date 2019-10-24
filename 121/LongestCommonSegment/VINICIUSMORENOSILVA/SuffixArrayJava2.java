/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Segmento comum mais longo e subpalíndromo mais longo
 * Data: 22/09/2017
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

public class SuffixArrayJava2 {
    private final String[] suffixes;
    private final int n;

    public SuffixArrayJava2(String s) {
        n = s.length();
        suffixes = new String[n];
        for (int i = 0; i < n; i++)
            suffixes[i] = s.substring(i);
        Arrays.sort(suffixes);
    }

    // size of string
    public int length() {
        return n;
    }

    // index of ith sorted suffix
    public int index(int i) {
        return n - suffixes[i].length();
    }

    // ith sorted suffix
    public String select(int i) {
        Arrays.sort(suffixes);
        return suffixes[i];
    }

    // number of suffixes strictly less than query
    public int rank(String query) {
        int lo = 0, hi = n - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            int cmp = query.compareTo(suffixes[mid]);
            if      (cmp < 0) hi = mid - 1;
            else if (cmp > 0) lo = mid + 1;
            else return mid;
        }
        return lo;
    } 

   // length of longest common prefix of s and t
    private static int lcp(String s, String t) {
        int n = Math.min(s.length(), t.length());
        for (int i = 0; i < n; i++)
            if (s.charAt(i) != t.charAt(i)) return i;
        return n;
    }

    // longest common prefix of suffixes(i) and suffixes(i-1)
    public int lcp(int i) {
        return lcp(suffixes[i], suffixes[i-1]);
    }

    // longest common prefix of suffixes(i) and suffixes(j)
    public int lcp(int i, int j) {
        return lcp(suffixes[i], suffixes[j]);
    }

    /*public String vector(int i) {
        return suffixes[i];
    }*/


}