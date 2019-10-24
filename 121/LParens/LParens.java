/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Exercício 1.3.9 de Algs4
 * Data: 27/10/2017
 *
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

public class LParens {

    public static void main(String[] args) {

        Stack<String> num = new Stack<String>();
        Stack<String> op = new Stack<String>();

        while (!StdIn.isEmpty()) {
            String s = StdIn.readString();
            if      (s.equals("+") || s.equals("*") || s.equals("-") ||
                            s.equals("/")) op.push(s);
            else if (s.equals(")")) num.push("(" + num.pop() + op.pop() + num.pop() + ")");
            else num.push(s);
        }
        StdOut.println(num.pop());
    }
}