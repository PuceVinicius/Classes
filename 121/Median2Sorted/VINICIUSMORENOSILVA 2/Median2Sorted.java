/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Web Exercise 2.5.23 (Median given two sorted arrays)
 * Data: 10/10/2017
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

public class Median2Sorted {

    public static Comparable select(Comparable[] a, Comparable[] b, int k){

        return select(k+1, 0, 0, a, b);
    }

    public static Comparable select(int k, int baseA, int baseB, Comparable[] a, Comparable[] b) {

        int contador = (k - baseA - baseB) / 2;
        int contadorA = baseA + contador;
        int contadorB = baseB + contador;
        int tamanhoA = a.length, tamanhoB = b.length;
        int condicao = baseA + baseB;

        if (condicao == k - 1) {

            if (tamanhoA > baseA && (tamanhoB <= baseB || a[baseA].compareTo(b[baseB]) < 0)) 
                return a[baseA];
            else
                return b[baseB];
        }

        if (tamanhoA > contadorA - 1 && (tamanhoB <= contadorB - 1 || a[contadorA - 1].compareTo(b[contadorB - 1]) < 0))
            baseA = contadorA;
        else
            baseB = contadorB;
        return select(k, baseA, baseB, a, b);
    }
}






