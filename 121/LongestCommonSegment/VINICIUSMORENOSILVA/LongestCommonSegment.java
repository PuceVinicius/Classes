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

public class LongestCommonSegment {

	public static void main (String[] args) {

		String s = "";
		String t = "";
		String contador = "";

		if (args.length > 0) {

			s = args[0];
			t = args[1];
			//StdOut.println(s);
			//StdOut.println(t);
		}
		else {
			s = StdIn.readLine();
			t = StdIn.readLine();
			s = s.replaceAll("\\s+", " ").trim();
			t = t.replaceAll("\\s+", " ").trim();

			SuffixArrayJava2 sS = new SuffixArrayJava2(s);
			SuffixArrayJava2 tT = new SuffixArrayJava2(t);

			for (int i = 0; i < s.length(); i++) {
				for (int j = 0; j < t.length(); j++) {
					//StdOut.println(sS.select(i));
					//StdOut.println(tT.select(j));
					if (sS.select(i).equals(tT.select(j))) {
						if (i <= j) {
							//StdOut.println(sS.select(i));
							//StdOut.println(tT.select(j));
							if (contador.length() < sS.select(i).length()) {
								contador = sS.select(i);
							}
						}
						else {
							//StdOut.println(sS.select(i));
							//StdOut.println(tT.select(j));
							if (contador.length() < tT.select(j).length()) {
								contador = tT.select(j);
							}
						}
					}
				}
			}
			StdOut.println(contador);
			//StdOut.println(tT.index(1));
		}
	}
}