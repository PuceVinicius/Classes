/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Caching ótimo
 * Data: 28/11/2017
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/
import java.util.HashMap;

public class Clairvoyant {

    public static void main(String[] args) {
        
        int tamCache = Integer.parseInt(args[0]);
        String[] seq = StdIn.readAllStrings();
        int[] aux = new int[seq.length];
        int indexNum = 0;
        int erros = 0;

        HashMap<Integer, Integer> index = new HashMap<Integer, Integer>();
        HashMap<String, Integer> conversor1 = new HashMap<String, Integer>();

        for (int i = seq.length - 1; i >= 0; i--) {

            if (conversor1.containsKey(seq[i])) {

                aux[i] = index.get(conversor1.get(seq[i]));
                index.replace(conversor1.get(seq[i]), i);
            }
            else {

                aux[i] = i + seq.length;
                index.put(indexNum, i);
                conversor1.put(seq[i], indexNum);
                indexNum++;
            }
        }

        HashMap<Integer, String> conversor2 = new HashMap<Integer, String>();
        IndexMaxPQ pq = new IndexMaxPQ(seq.length+1);

        for (int i = 0; i < seq.length; i++) {

            if (pq.contains(conversor1.get(seq[i]))) {

                conversor2.put(conversor1.get(seq[i]), seq[i]);
                pq.change(conversor1.get(seq[i]), aux[i]);
                if (args.length != 1) {

                    StdOut.println(seq[i] + ": in cache");
                }
            }

            else if (pq.size() < tamCache) {

                conversor2.put(conversor1.get(seq[i]), seq[i]);
                pq.insert(conversor1.get(seq[i]), aux[i]);
                if (args.length != 1) {

                    StdOut.println(seq[i] + ": +" + seq[i]);
                }
                erros++;
            }

            else {

                pq.insert(conversor1.get(seq[i]), aux[i]);
                conversor2.put(conversor1.get(seq[i]), seq[i]);
                if (args.length != 1) {

                    StdOut.println(seq[i] + ": -" + conversor2.get(pq.delMax()) + "/+" + seq[i]);
                }
                erros++;
            }
        }

        StdOut.println("Number of cache misses: " + erros);
    }
}