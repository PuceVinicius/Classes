public class Ortho {

	/*public static void buscaBinaria() {
		boolean isWhitespace = palavra[j].matches("^\\s*");
	}*/
	public static int search(String key, String[] a) { 
		//StdOut.println(key);
		return search(key, a, 0, a.length); 
	}

	public static int search(String key, String[] a, int lo, int hi) {
 		if (hi <= lo) return -1;
 		int mid = lo + (hi - lo) / 2;
 		int cmp = a[mid].compareTo(key);
 		if (cmp > 0) return search(key, a, lo, mid);
 		else if (cmp < 0) return search(key, a, mid+1, hi);
 		else return mid;
	}

	public static void main(String[] args) {

		In dicionarioBruto = new In(args[0]);
		String[] dicionario = dicionarioBruto.readAllLines();
		String[] bruto = StdIn.readAllLines();
		String rola = "";
		String buceta = "";
		int guia = 0;

		/*for (int i = 0; i < dicionarioLinhas.length; i++) {
			String base1 = dicionarioLinhas[i];
			rola = rola + " " + base1;
		}
		String[] dicionario = rola.split("[^a-zA-Z]");*/

		for (int i = 0; i < bruto.length; i++) {
			String base2 = bruto[i];
			buceta = buceta + " " + base2;
			//StdOut.println(1);
		}
		String[] texto = buceta.split("[^a-zA-Z]");

		for (int i = 0; i < texto.length; i++) {
			boolean condEspaco = texto[i].matches("^\\s*");
			if (condEspaco == false) {
				guia = search(texto[i], dicionario);
				if (guia > 0) StdOut.println(texto[i]);
			} 
		}
	}
}