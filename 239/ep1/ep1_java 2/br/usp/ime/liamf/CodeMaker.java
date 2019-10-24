package br.usp.ime.liamf;

import java.util.concurrent.ThreadLocalRandom;

public class CodeMaker {

    private int nSlots, nColors;
    private int[] code;

    CodeMaker(int nSlots, int nColors){
        this.nSlots = nSlots;
        this.nColors = nColors;
        this.code = this.createCode();
    }

    private int[] createCode() {
        int[] code = new int[nSlots];

        for (int i = 0; i < this.nSlots; i++) {
            int x = ThreadLocalRandom.current().nextInt(0, nColors);
            code[i] = x;
        }
        return code;
    }

    /* A feedback is a list, indicating for each position it has: True if
    the guess at that position was right, False otherwise.*/
    public boolean[] feedback(int[] guess) {

        boolean[] feedback = new boolean[nSlots];

        for (int i = 0; i < this.nSlots; i++) {
            feedback[i] = (guess[i] == this.code[i]);
        }
        return feedback;
    }

    public void printCode() {
        System.out.print("Code: ");
        for (Integer e : this.code) {
            System.out.print(e);
            System.out.print(" ");
        }
        System.out.print("\n");
    }
}
