public class teste {
	public static void main(String[] args) {

		double y0 = 2;
		double v0 = 0;
		double g = -9.8;
		double v = v0;
		double y = y0;
		double vC = v0;
		double yC = y0;
		double dt = 0.1;
		double t = 0;
		double tC = 0;
		double k = 1;
		double omega0 = Math.sqrt(k);
		double e = 0;
		double eC = 0;
		double eAnalitic = 0;

		//Euler method
		for (int i = 0; i < 10000; i++) {
			y = y + v*dt;
			v = v - k*y*dt;
			t = t + dt;
		}
		e = v*v/2 + y*y/2;

		//Euler method
		/*while (y > 0) {
			v = v - k*y*dt;
			y = y + v*dt;
			t = t + dt;
		}*/

		//Euler-Cromer method
		for (int i = 0; i < 10000; i++) {
			vC = vC - k*yC*dt;
			yC = yC + vC*dt;
			tC = tC + dt;
		}
		eC = vC*vC/2 + yC*yC/2;

		//Analitic method
		double yAnalitic = y0*Math.cos(omega0*t) + v0/omega0*Math.sin(omega0*t);
		double vAnalitic = -(y0)*omega0*Math.sin(omega0*t) + v0*Math.cos(omega0*t);

		eAnalitic = vAnalitic*vAnalitic/2 + yAnalitic*yAnalitic/2;

		System.out.println();
		System.out.println();
		System.out.println("Results (Euler):");
		System.out.println("Final t: " + t);
		System.out.println("y = " + y);
		System.out.println("v = " + v);
		System.out.println("e = " + e);

		System.out.println("Results (Euler-Cromer):");
		System.out.println("Final tC: " + tC);
		System.out.println("yC = " + yC);
		System.out.println("vC = " + vC);
		System.out.println("eC = " + eC);

		System.out.println("Results (Analitic):");
		System.out.println("y = " + yAnalitic);
		System.out.println("v = " + vAnalitic);
		System.out.println("e = " + eAnalitic);
		System.out.println();
		System.out.println();
	}
}