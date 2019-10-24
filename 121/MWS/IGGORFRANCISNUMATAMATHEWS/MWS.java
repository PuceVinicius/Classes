/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Iggor Francis Numata Mathews
 * Numero USP: 10262572
 * Tarefa: Multiple word search
 * Data: 09/11/2017
 *
 * DECLARO QUE SOU O UNICO AUTOR E RESPONSAVEL POR ESTE PROGRAMA.  TODAS AS
 * PARTES DO PROGRAMA, EXCETO AS QUE SaO BASEADAS EM MATERIAL FORNECIDO
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE,
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBEM QUE SOU RESPONSAVEL POR TODAS
 * AS COPIAS DESTE PROGRAMA E QUE NAO DISTRIBUI NEM FACILITEI A DISTRIBUICAO
 * DE COPIAS DESTA PROGRAMA.
 *
 *****************************************************************************/


import java.util.Arrays;

public class MWS {

	public static int findWord (String key, String[] dicio, int lo, int hi) {
		if (lo > hi)
			return -1;
		int mid = (lo + hi) / 2;
		if (key.compareTo(dicio[mid]) > 0)
			return findWord (key, dicio, mid+1, hi);
		else if (key.compareTo(dicio[mid]) < 0)
			return findWord (key, dicio, lo, mid-1);
		else
			return mid;
	}

	public static void main (String[] args) {
		In textIn = new In(args[0]);
		In dicioIn = new In(args[1]);
		String words = textIn.readAll();
		String[] dicio = dicioIn.readAllStrings();

		String[] text = words.split("\\s+|(?=\\p{Punct})|(?<=\\p{Punct})");
		Arrays.sort(dicio);

		int cont[] = new int[dicio.length];
		int difw = 0;
		int p1 = 0, p2 = 0;
		int smaller = text.length;
		int s1 = 0, s2 = 0;
		int isContained = 0;

		for (int i=0; i<text.length; i++) {
			int pos = findWord (text[p1], dicio, 0, dicio.length-1);
			if (pos != -1) {
				if (cont[pos] == 0)
					difw++;
				cont[pos]++;
				if (difw - dicio.length == 0) {
					isContained = 1;
					for (int j = p2; j < p1; j++) {
						int pos2 = findWord (text[p2], dicio, 0, dicio.length
																		-1);
						if (pos2 != -1){
							cont[pos2]--;
							if (cont[pos2] == 0) {
								difw--;
								if (p1 - p2 +1 < smaller){
									smaller = p1 - p2 +1;
									s1 = p1;
									s2 = p2;
								}
								break;
							}
						}
						p2++;
					}
				}
			}
			p1++;
		}

		int flag = 0;
		if (isContained == 0) {
			StdOut.print ("Set of words not in text: { ");
			for (int i=0; i < dicio.length; i++) {
				if (flag == 0) {
					if (cont[i] == 0) {
						flag = 1;
						StdOut.print (dicio[i]);
					}
				}
				else
					StdOut.print (", " + dicio[i]);
			}
			StdOut.println (" }");
		}
		else {
			StdOut.println ("Number of words in interval: " + smaller);
			if (args.length > 2){
				for (int i=s2; i <= s1; i++){
					if (findWord(text[i], dicio, 0, dicio.length-1) != -1)
						text[i] = ("*" + text[i] + "*");
					StdOut.print(text[i] + " ");
				}
			}
		}
	}
}