package br.usp.ime.liamf;

import java.io.IOException;

/* Represents the game itself */
public class Mastermind {

    private int nTries;
    private CodeMaker codeMaker;
    private CodeBreaker codeBreaker;

    Mastermind(int nSlots, int nColors, int nTries) throws IOException {
        this.codeMaker = new CodeMaker(nSlots, nColors);
        this.codeBreaker = new CodeBreaker(nSlots, nColors);
        this.codeMaker.printCode();
        this.nTries = nTries;
    }

    public boolean play() throws IOException, InterruptedException {
        int[] guess;
        boolean[] feedback;
        for (int i = 0; i < nTries; i++) {
            guess = this.codeBreaker.guess();
            printGuess(guess, i);
            feedback = this.codeMaker.feedback(guess);
            if (this.codeBreaker.convertFeedback(feedback)) {
                return true;
            }
        }
        return false;
    }

    public void printGuess(int[] guess, int nTry) {
        System.out.print("Guess " + (nTry + 1) + ": ");
        for (int e : guess) {
            System.out.print(e);
            System.out.print(" ");
        }
        System.out.print("\n");
    }
}
