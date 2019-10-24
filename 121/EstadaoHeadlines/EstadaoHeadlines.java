/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Tarefa: Manchetes
 * Data: 22/08/2017
 * 
 * Baseado em HTMLSource.java
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

import org.apache.commons.lang3.StringEscapeUtils;

public class EstadaoHeadlines {

    private static void readHTML(String URL) {
        In page = new In(URL);
        String html = page.readAll();
        String htmlFinal = "";
        if (html.contains("<title></title>")) return;
        else {
			int tamanho = html.length();
			int inicioString = 0;
        	for(int i = 0; i < tamanho-6; i++) {
        		if (html.charAt(i) == '<' && html.charAt(i+1) == 'h' && html.charAt(i+2) == '3') { 
       				for(int k = i + 2; html.charAt(k) != '>'; k++) {
       					inicioString = k + 2;
       				}
        		}
        		if (html.charAt(i) == '<' && html.charAt(i+1) == '/' && html.charAt(i+2) == 'h' &&
        			html.charAt(i+3) == '3' && html.charAt(i+4) == '>') {
        			int finalString = i;
        			htmlFinal = html.substring(inicioString, finalString);
        			StdOut.println(StringEscapeUtils.unescapeHtml4(htmlFinal));
        			htmlFinal = "";
        		}
        	}
        	return;
        }
    }

    public static void main(String[] args) {
        String URL = "http://www.estadao.com.br";
		readHTML(URL);
    }

}
