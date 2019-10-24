public class UnionOfIntervals {

	public static void main(String[] args) {

		double taxa = 0.0;



		StdDraw.setXscale(-0.05, 1.05);
    	StdDraw.setYscale(-0.05, 1.05);

    	StdDraw.setPenColor(StdDraw.GRAY);
    	StdDraw.setPenRadius(0.002);
    	//for (int i=0; i < xavasca; i++){
    		StdDraw.line(0.35, -0.05, 0.35, 1.05);
    	//}

    	StdDraw.setPenColor(StdDraw.BLACK);
		StdDraw.setPenRadius(0.0045);
    	//for (int i=0; i < xavasca; i++){
    		StdDraw.line(0.35, 0.15 + taxa, 0.70 + taxa, 0.15);
    		taxa += 0.03;
    	//}
    }
}