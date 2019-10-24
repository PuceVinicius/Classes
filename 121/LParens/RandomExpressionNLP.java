/******************************************************************************
 *
 * $ java-introcs RandomExpressionNLP .127
 * 98 / 2 - 86 ) * 48 * 34 ) ) - 54 ) ) / 36 * 16 - 12 ) - 46 ) / 87 ) ) / 96 ) + 96 ) )
 * $ java-introcs RandomExpressionNLP .127
 * 57
 * java-introcs RandomExpressionNLP .127 | java-introcs LParens
 * ( 52 - ( ( 40 / 89 ) - ( 1 - ( ( 40 - 39 ) / 67 ) ) ) )
 * 
 ******************************************************************************/


public class RandomExpressionNLP {

    public static String generate(double p) {
        double r = StdRandom.uniform();
        if      (r <= p)   return generate(p) + " + " + generate(p) + " )";
        else if (r <= 2*p) return generate(p) + " - " + generate(p) + " )";
        else if (r <= 3*p) return generate(p) + " * " + generate(p) + " )";
        else if (r <= 4*p) return generate(p) + " / " + generate(p) + " )";
        else               return "" + StdRandom.uniform(100);
    }

    public static void main(String[] args) {
        double p = Double.parseDouble(args[0]);
        StdOut.println(generate(p));
    }
}
