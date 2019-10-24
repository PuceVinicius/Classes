/*public class Ex2{
	
	public static void main(String[] args){
		double y0 = 10;
		double v0 = 0;
		double t = 0;
		double dt = 0.01;
		double y = y0;
		double v = v0;
		double g = 9.8;
		int i = 0;

		//fui mudando o dt para 0.01, 0.1, 1.. e aumentando o y0 conforme era necessário
		for(double i = 0; i < 100; i++){
			y = y + v*dt;
			v = v - g*dt;
			t = t + dt;
		}

		//essa parte é pra saber o tempo quando y = 0
		/*while (y > 0){
			y = y + v*dt;
			v = v - (g + dt)*dt;
			t = t + dt;
			i++;
		}

		System.out.println("Results (Euler):");
		System.out.println("Final time: " + t);
		System.out.println("y = " + y);
		System.out.println("v = " + v);

		double yAnalitic = y0 + v0*t - 0.5*g*t*t;
		double vAnalitic = v0 - g*t;
		System.out.println("Results (Analitic):");
		System.out.println("y = " + yAnalitic);
		System.out.println("v = " + vAnalitic);
	}
}*/

public class Ex2{

    public static void main(String[] args){
        double y0 = 0;
        double v0 = 0;
        double t = 0;
        double dt = 0.1;
        double tC = 0;
        double y = 0;
        double yC = 0;
        double vC = 0;
        double v = 0;
        int i = 0;
        final double a = 2;
        //fui mudando o dt para 0.01, 0.1, 1.. e aumentando o y0 conforme era necessário
        for(i = 0; i < 100; i++){
            y = y + v*dt;
            v = v + a*dt;
            t = t + dt;
        }

        for(i = 0; i < 100; i++){
            vC = vC + a*dt;
            yC = yC + vC*dt;
            tC = tC + dt;
        }

        //essa parte é pra saber o tempo quando y = 0
        /*while (y > 0){
            y = y + vdt;
            v = v - (a + dt)dt;
            t = t + dt;
            i++;
        }*/

        System.out.println("Results (Euler):");
        System.out.println("Final time: " + t);
        System.out.println("y = " + y);
        System.out.println("v = " + v);

        System.out.println("Results (EulerCromer):");
        System.out.println("Final time: " + tC);
        System.out.println("yC = " + yC);
        System.out.println("vC = " + vC);

        // double yAnalitic = y0 + v0t - 0.5att;
        // double vAnalitic = v0 - a*t;
        // System.out.println("Results (Analitic):");
        // System.out.println("y = " + yAnalitic);
        // System.out.println("v = " + vAnalitic);
    }
}