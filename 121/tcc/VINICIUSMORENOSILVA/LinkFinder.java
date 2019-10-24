/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Pagerank
 * Data: 16/12/2017
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.net.*;

public class LinkFinder {

    public static Queue<String> links(String page, String url) throws Exception {
	Queue<String> links = new Queue<String>();
	String regexp = "href\\s*=\\s*\"[[\\S]&&[^\"]]+\"|https?://[[\\S]&&[^\"]]+\\.[[\\S]&&[^\"\']]+";
	Pattern pattern = Pattern.compile(regexp);
	Matcher matcher = pattern.matcher(page);

	while (matcher.find()) {
	    String g = matcher.group();
	    // StdOut.println("... " + g);
	    if (g.startsWith("href")) {
		int t = g.indexOf("\"");
		g = g.substring(t + 1, g.length() - 1);
		// StdOut.println("..... " + g);
		if (g.startsWith("mailto:")) continue;
		if (g.startsWith("file:")) continue;
		if (g.startsWith("javascript:")) continue;
		if (g.contains("validator.w3.org")) continue;
		if (g.contains("sandbox")) continue;
	    }
	    if (!g.startsWith("http")) {
		g = url + "/" + g;
		// StdOut.println("....... " + g);
		g = g.replaceAll("//+", "/");
		// StdOut.println("....... " + g);
		g = g.replaceFirst("http:/", "http://");
		g = g.replaceFirst("https:/", "https://");
	    }
	    if (g.contains("wikipedia"))
		g = treatWikiLinks(g);
	    if (g == null) continue;
	    int i = g.indexOf('#');
	    if (i >= 0) g = g.substring(0, i);
	    i = g.indexOf("...");
	    if (i >= 0) g = g.substring(0, i);
	    i = g.indexOf('<');
	    if (i >= 0)	g = g.substring(0, i);
	    i = g.indexOf('>');
	    if (i >= 0)	g = g.substring(0, i);
	    i = g.indexOf("/>");
	    if (i >= 0)	g = g.substring(0, i);
	    if (g.endsWith("/")) g = g.substring(0, g.length() - 1);
	    URI uri = null;
	    try {
		uri = new URI(g);
	    } catch (Exception e) {
		System.err.println("Didn't understand URL " + g);
		continue;
	    }
	    links.enqueue(uri.normalize().toString());
	}
	
	return links;
    }

    public static boolean validLink(String url, String want) {
	String webserver = webserver(url);
	if (!webserver.contains(want)) return false;
	if (url.contains(".js")) return false;
	if (url.contains(".css")) return false;
	if (url.endsWith(".png")) return false;
	if (url.endsWith(".PNG")) return false;
	if (url.endsWith(".jpg")) return false;
	if (url.endsWith(".JPG")) return false;
	if (url.endsWith(".gif")) return false;
	if (url.endsWith(".GIF")) return false;
	if (url.endsWith(".pdf")) return false;
	if (url.endsWith(".PDF")) return false;
	if (url.endsWith(".ps")) return false;	
	if (url.endsWith(".gz")) return false;	
	if (url.endsWith(".ogg")) return false;	
	return true;
    }

    public static boolean containsInPage(String url, String want) {
	In page = new In(url);
    String html = page.readAll();
    if (!html.contains(want)) return false;
	return true;
    }

    public static String treatWikiLinks(String gg) {
	if (!gg.contains("/wiki/")) { gg = null; return null; }
	int i = gg.indexOf("/wiki/");
	int j = gg.lastIndexOf("/wiki/");
	if (i < j) gg = gg.substring(0, i) + gg.substring(j);
	return gg;
    }

    public static String webserver(String url) {
	String name = "";
	if (url.startsWith("http://")) {
	    name = url.substring(7);
	} else if (url.startsWith("https://")) {
	    name = url.substring(8);
	}
	int i = name.indexOf("/");
	if (i >= 0)
	    name = name.substring(0, i);
	i = name.indexOf("?");
	if (i >= 0)
	    name = name.substring(0, i);
	return name;
    }

    public static void main(String[] args) throws Exception {
	String url = args[0];
	
	String page = null;
	try {
	    In in = new In(url);
	    page = in.readAll();
	    Out out = new Out("local_copy.html");
	    out.println(page);
	} catch (IllegalArgumentException e) {
	    StdOut.println("Could not open " + url);
	    System.exit(0);
	}
	Queue<String> q = links(page, url);
	for (String x : q)
	    StdOut.println(x);
    }
}
