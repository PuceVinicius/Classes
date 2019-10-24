/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Número de ocorrências em lista ordenada
 * Data: 19/09/2017
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

public class CountOccurrences {

    public static int search(int key, int[] a) { 
        return search(key, a, 0, a.length);
    } 

    public static int search(int key, int[] a, int lo, int hi) {

        if (hi <= lo) return lo;
        int mid = lo + (hi - lo) / 2;
        if (key <= a[mid]) return search(key, a, lo, mid);
        else return search(key, a, mid+1, hi);
        /*int cmp = a[mid].compareTo(key);
        if (cmp > 0) return search(key, a, lo, mid);
        else if (cmp < 0) return search(key, a, mid+1, hi);
        else return mid;*/
    }

    public static void main(String[] args) {

    	In comparadorBruto = new In(args[0]);

    	int[] comparador = comparadorBruto.readAllInts();
    	int[] base = StdIn.readAllInts();

        for (int i=0; i < base.length; i++) {
            StdOut.println(Math.abs(search(base[i], comparador) - search(base[i] + 1, comparador)));
        }




    	/*int[] contadores = new int[comparador[comparador.length-1]+1];


    	for (int i=0; i < comparador.length; i++) {
    		contadores[comparador[i]] += 1;
    	}

    	for (int i=0; i < base.length; i++) {
    		if (base[i] <= comparador[comparador.length-1]) {
    			StdOut.println(contadores[base[i]]);
    		}
    		else {
    			StdOut.println("0");
    		}
    	}*/
	}
}