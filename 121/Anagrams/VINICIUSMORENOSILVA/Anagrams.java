/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Web Exercise 4.2.12 (Anagrams)
 * Data: 15/09/2017
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

public class Anagrams {

	public static void main(String[] args) {

		String[] palavrasBruto = StdIn.readAllLines();
		String[] palavras = new String[palavrasBruto.length];
		int[] condicao = new int[palavrasBruto.length];
		int espaco = 0;
		String base = "";


		for (int i = 0; i < palavrasBruto.length; i++) {
			palavras[i] = palavrasBruto[i];
			base = palavras[i].toLowerCase();
			char[] letras = base.toCharArray();
			Arrays.sort(letras);
			palavras[i] = String.valueOf(letras) + " " + palavras[i];
		}

		Arrays.sort(palavras);

		String[] Comparador1 = new String[2];
		String[] Comparador2 = new String[2];

		for (int i = 0; i < palavras.length; i++) {
			if (i != palavras.length - 1) {
				Comparador1 = palavras[i].split("\\s+");
				Comparador2 = palavras[i+1].split("\\s+");
				if (Comparador1[0].equals(Comparador2[0])) {
					if (condicao[i] == 0) {
						condicao[i] = i+1;
						condicao[i+1] = i+1;
						if (espaco > 0) {
							StdOut.println();
						}
						StdOut.print("* " + Comparador1[1] + " " + Comparador2[1]);
						espaco++;
					}
					else {
						condicao[i+1] = condicao[i];
						StdOut.print(" " + Comparador2[1]);
					}
				}
			}
			else {
				Comparador1 = palavras[i-1].split("\\s+");
				Comparador2 = palavras[i].split("\\s+");
				if (Comparador1[0] == Comparador2[0]) {
					StdOut.print(" " + Comparador2[1]);
				}
			}
		}
	}
}