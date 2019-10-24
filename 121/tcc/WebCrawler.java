/******************************************************************************
 * $ java-introcs WebCrawler http://www.ime.usp.br ime.usp.br 200 > IME.200.pages.out
 * $ java-introcs WebCrawler http://www.usp.br usp.br 200 > USP.200.pages.out
 ******************************************************************************/

public class WebCrawler {

    private static void recycle(String v, Queue<String> q, ST<String, Integer> noTries) {
	if (!noTries.contains(v)) {
	    noTries.put(v, 1);
	    q.enqueue(v);
	    return;
	}
	int triesSoFar = noTries.get(v);
	if (triesSoFar < 20) { // HARD CODED!
	    noTries.put(v, triesSoFar + 1);
	    q.enqueue(v);
	}
    }

    public static void main(String[] args) throws Exception { 
        // timeout connection after 500 miliseconds
        System.setProperty("sun.net.client.defaultConnectTimeout", "500");
        System.setProperty("sun.net.client.defaultReadTimeout",    "2000");

        String s = args[0];  // initial web page for BFS
        String t = args[1];  // must contain t in webserver's name
        int countIni = 0;
        int countEnd = 0;
        int countMid = 0;
        String base = "";
        int MAXN = Integer.parseInt(args[2]);
        Queue<String> q = new Queue<String>();
        q.enqueue(s);
		SET<String> discovered = new SET<String>();
        discovered.add(s);
        SET<String> visited = new SET<String>();
		ST<String, Integer> numberOfTries = new ST<String, Integer>();
        while (!q.isEmpty() && visited.size() < MAXN) {
            String v = q.dequeue();
	    	if (visited.contains(v)) continue;
            String input = null;
            try {
                In in = new In(v);
                input = in.readAll();
            } 	catch (IllegalArgumentException e) {
                	StdOut.println("[could not open " + v + "]");
					recycle(v, q, numberOfTries);
                	continue;
            	}
		    visited.add(v);
		    q.enqueue(v);
		    for (int i = 0; i < v.length(); i++) {
	    		if (v.charAt(i) == '/') {
	    			countMid++;
	    			if (countMid == 2) { 
	    				countIni = i;
	    			}
	    			if (countMid == 3) {
	    				countEnd = i;
	    				i = v.length();
	    			}
	    		}
	    		if (countMid == 2 && i == v.length() - 2) {
	    			countEnd = i + 2;
	    			i = v.length();
	    		}
	    	}
	    	base = v.substring(countIni + 1, countEnd);
	    	countMid = 0;
	    	StdOut.print(base);
		    Queue<String> links = LinkFinder.links(input, v);
		    for (String w : links) {
				if (LinkFinder.validLink(w, t) && !discovered.contains(w)) {
			    	try {
					In in = new In(w);
			    	} catch (Exception e) {
					continue;
			    	}
			    	q.enqueue(w);
			    	discovered.add(w);
			    	for (int i = 0; i < w.length(); i++) {
			    		if (w.charAt(i) == '/') {
			    			countMid++;
			    			if (countMid == 2) countIni = i;
			    			if (countMid == 3) {
			    				countEnd = i;
			    				i = w.length();
			    			}
			    		}
			    		if (countMid == 2 && i == w.length() - 2) {
	    					countEnd = i + 2;
	    					i = w.length();
	    				}
			    	}
			    	base = w.substring(countIni + 1, countEnd);
			    	countMid = 0;
			    	StdOut.print(" " + base);
			    	if (q.size() > 	MAXN - 1) {
			    		continue;
			    	}
				}
		    }
		    StdOut.println();
		}
    }
}
