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
public class LocateBST {

	public static void exch(String[] a, int i, int j) {
        String swap = a[i];
        a[i] = a[j];
        a[j] = swap;
    }

    public static void shuffle(String[] a) {
        int n = a.length;
        for (int i = 0; i < n; i++) {
            int r = i + (int) (Math.random() * (n-i));
            exch(a, i, r);
        }
    }

   public static void main(String[] args) {
   	
        BST<Integer, Integer> arvore = new BST<Integer, Integer>();

        In intervalosBruto = new In(args[0]);
        String[] intervalosBase = intervalosBruto.readAllLines();

        shuffle(intervalosBase);

        for (int i = 0; i < intervalosBase.length; i++) {
        	String[] intervalos = intervalosBase[i].split("\\s+");
            Integer key = Integer.parseInt(intervalos[0]);
            Integer value = Integer.parseInt(intervalos[1]);
            arvore.put(key, value);
        }

        String[] numeros = StdIn.readAllLines();

        for (int i = 0; i < numeros.length; i++) {

        	int n = Integer.parseInt(numeros[i]);

        	if (arvore.ceiling(n) == null && n != arvore.get(arvore.floor(n))) {
        		StdOut.println(numeros[i] + ": right of [" + arvore.floor(n) + 
        						", " + arvore.get(arvore.floor(n)) + "]");
        	}
        	else if (arvore.floor(n) == null && n != arvore.get(arvore.ceiling(n))) {
        		StdOut.println(numeros[i] + ": left of [" + arvore.ceiling(n) + 
        						", " + arvore.get(arvore.ceiling(n)) + "]");
        	}
        	else if (arvore.get(arvore.floor(n)) >= n) {
        		StdOut.println(numeros[i] + ": [" + arvore.floor(n) + 
        						", " + arvore.get(arvore.floor(n)) + "]");
        	}
        	else {
        		StdOut.println(numeros[i] + ": between [" + arvore.floor(n) + 
        						", " + arvore.get(arvore.floor(n)) +
        						"] & [" + arvore.ceiling(n) + 
        						", " + arvore.get(arvore.ceiling(n)) + "]");
        	}
        }
    }
}