/******************************************************************************
 *
 * $ java-introcs HTMLSource https://www.ime.usp.br/~yoshi/ > y.html
 * $ java-introcs HTMLSource https://www.ime.usp.br/~yoshi/ - > yy.html
 *
 ******************************************************************************/

import org.apache.commons.lang3.StringEscapeUtils;

public class HTMLSource {

    private static String readHTML(String URL) {
        In page = new In(URL);
        String html = page.readAll();
        if (html.contains("<title></title>")) return null;
        else return html;
    }

    public static void main(String[] args) {
        String URL = args[0];
	String html = readHTML(URL);
	if (args.length > 1)
	    StdOut.println(StringEscapeUtils.unescapeHtml4(html));
	else
	    StdOut.println(html);
    }

}
