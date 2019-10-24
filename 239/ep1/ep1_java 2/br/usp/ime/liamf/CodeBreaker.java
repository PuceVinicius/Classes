package br.usp.ime.liamf;

import java.io.IOException;

/* Represents the player trying to break the code */
public class CodeBreaker {

    private int nSlots, nColors;
    private int[] lastGuess;
    private SATtradutor satTradutor;

    CodeBreaker(int nSlots, int nColors) throws IOException {
        this.nSlots = nSlots;
        this.nColors = nColors;
        this.lastGuess = null;
        this.satTradutor = new SATtradutor(nSlots, nColors);
        this.generateFixedClauses();
    }

    private void generateFixedClauses() throws IOException {
        generateRuleMostOneColor();
        generateRuleLeastOneColor();
    }

    private void generateRuleLeastOneColor() throws IOException {
        for (int i = 0; i < this.nSlots; i++) {
            int[] clause = new int[nColors];
            for (int j = 0; j < this.nColors; j++) {
                clause[j] = this.satTradutor.attToVar(i, j);
            }
            satTradutor.addClause(clause);
        }
    }

    private void generateRuleMostOneColor() throws IOException {
        for (int i = 0; i < this.nSlots; i++) {
            for (int j = 0; j < this.nColors - 1; j++) {
                for (int k = j + 1; k < this.nColors; k++) {
                    int[] clause = new int[2];
                    clause[0] = (-1 * satTradutor.attToVar(i, j));
                    clause[1] = (-1 * satTradutor.attToVar(i, k));
                    satTradutor.addClause(clause);
                }
            }
        }
    }

    /* Uses a SAT solver to make a guess */
    public int[] guess() throws IOException, InterruptedException {
        this.lastGuess = satTradutor.runSolver();
        return this.lastGuess;
    }

    /*  This function should add clauses corresponding to the feedback obtained
        by the last guess.
        Returns true if won the game, false otherwise. */
    public boolean convertFeedback(boolean[] feedback) throws IOException {
        int count = 0;
        for (int i = 0; i < this.nSlots; i++) {
            if (feedback[i]) {
                count++;
            }
        }
        if (count == this.nSlots)
            return true;

        /* Comment and uncomment these lines to test different strategies */
        //strategySimple(feedback);

        strategyFull(feedback);
        // strategyNew(feedback);

        /* Do not the return statement */
        return false;
    }

    private void strategySimple(boolean[] feedback) throws IOException {
        int[] clause = new int[nSlots];
        for (int i = 0; i < this.nSlots; i++) {
            clause[i] = -1 * satTradutor.attToVar(i, this.lastGuess[i]);
        }
        this.satTradutor.addClause(clause);
    }

    private void strategyFull(boolean[] feedback) throws IOException {

        for (int i = 0; i < this.nSlots; i++) {
            int[] clause = new int[1];
            if (feedback[i])
                clause[0] = (satTradutor.attToVar(i, lastGuess[i]));
            else
                clause[0] = (-1 * satTradutor.attToVar(i, lastGuess[i]));
            satTradutor.addClause(clause);
        }
    }

    /* Create this one */
    private void strategyNew(boolean[] feedback) {
        return;
    }
}
