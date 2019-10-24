package br.usp.ime.liamf;

import java.io.IOException;

public class Main {

    public static void main(String[] args) {
        int nSlots = new Integer(args[0]);
        int nColors = new Integer(args[1]);
        int nTries = new Integer(args[2]);
        String winner;
        try {
            Mastermind game = new Mastermind(nSlots, nColors, nTries);
            if (game.play())
                winner = "CodeBreaker";
            else
                winner = "CodeMaker";
            System.out.println(winner + " wins!");
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
