/******************************************************************************
 *
 * $ java-introcs HTMLSource https://www.ime.usp.br/~yoshi/ > y.html
 * $ java-introcs HTMLSource https://www.ime.usp.br/~yoshi/ - > yy.html
 *
 ******************************************************************************/

import org.apache.commons.lang3.StringEscapeUtils;

public class EstadaoHeadlines {

    private static void readHTML(String URL) {
        In page = new In(URL);
        String html = page.readAll();
        String htmlFinal = "";
        if (html.contains("<title></title>")) return null;
        else {
			int tamanho = html.length();
        	for(int i = 0; i < tamanho-6; i++) {
        		int inicioString = 0;
        		if (html.substring(i, i+3) == "<h3") { 
       				for(int k = i + 2; html.charAt(k) != '>'; k++) {
       					inicioString = k + 1;
       				}
        		}
        		if (html.substring(i, i+5) == "</h3>") {
        			int finalString = i + 5;
        			htmlFinal = html
        		}
        	}
        }
    }

    public static void main(String[] args) {
        String URL = args[0];
		readHTML(URL);
		if (args.length > 1)
	 	   StdOut.println(StringEscapeUtils.unescapeHtml4(html));
		else
	  	StdOut.println(html);
    }

}
