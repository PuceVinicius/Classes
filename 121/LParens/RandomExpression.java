/******************************************************************************
 *  Compilation:  javac RandomExpression.java
 *  Execution:    java RandomExpression p
 *  
 *  %  java RandomExpression 0.25
 *  2
 * 
 *  % java RandomExpression 0.25
 *  ((38 + (67 * (15 + 53))) + ((14 * (63 * (76 + (((1 + 78) + ((14 * 41) + (8 + 67))) + ((50 * (53 * (((39 * 19) * 24) + 88))) + 15))))) * 97))
 *
 *  % java RandomExpression 0.25
 *  ((56 * 28) * (52 + 52))
 * 
 *  % java Expr 0.3
 *  Exception in thread "main" java.lang.StackOverflowError
 *          at java.lang.System.arraycopy(Native Method)
 *          at java.lang.String.getChars(String.java:726)
 *
 ******************************************************************************/


public class RandomExpression {

    public static String generate(double p) {
        double r = StdRandom.uniform();
        if      (r <= p)   return "(" + generate(p) + " + " + generate(p) + ")";
        else if (r <= 2*p) return "(" + generate(p) + " * " + generate(p) + ")";
        else               return "" + StdRandom.uniform(100);
    }

    public static void main(String[] args) {
        double p = Double.parseDouble(args[0]);
        StdOut.println(generate(p));
    }
}
