package br.usp.ime.liamf;

import java.io.*;

/*  Encapsulates the SAT solver */

public class SATtradutor {

    private int nSlots, nColors, nClauses;
    private final String FILENAME = "mastermindsat.txt";

    SATtradutor(int nSlots, int nColors) throws IOException {
        this.nSlots = nSlots;
        this.nColors = nColors;
        this.nClauses = 0;
        this.writeHeader();
    }

    // Writes the header of the SAT file
    private void writeHeader() throws IOException {
        FileOutputStream out = new FileOutputStream(this.FILENAME);
        String header = "c\n";
        header += "c Mastermind - SAT\n";
        header += "c\n";
        int nVars = this.nSlots * this.nColors;
        header += "p cnf " + nVars + " " + nClauses + "\n";
        out.write(header.getBytes());
        out.close();
    }

    // Fixes the header of the SAT file
    private void rewriteHeader() throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(this.FILENAME));
        String line;
        int counter = 0;
        StringBuffer inputBuffer = new StringBuffer();
        while ((line = in.readLine()) != null) {
            if (counter == 3) {
                int nVars = this.nSlots * this.nColors;
                line = "p cnf " + nVars + " " + nClauses;
            }
            inputBuffer.append(line);
            inputBuffer.append('\n');
            counter++;
        }
        String dataString = inputBuffer.toString();
        FileOutputStream out = new FileOutputStream(this.FILENAME);
        out.write(dataString.getBytes());
        out.close();
    }

    // Adds a single clause to the SAT file
    public void addClause(int[] clause) throws IOException {
        FileOutputStream out = new FileOutputStream(this.FILENAME, true);
        this.nClauses += 1;
        for (int var : clause) {
            out.write(String.valueOf(var).getBytes());
            out.write(" ".getBytes());
        }
        out.write("0\n".getBytes());
        out.close();
    }

    public int[] runSolver() throws IOException, InterruptedException {
        this.rewriteHeader();
        ProcessBuilder processBuilder = new ProcessBuilder("./lingeling", "-q", this.FILENAME);
        Process process = processBuilder.start();
        process.waitFor();
        int[] result = parseAnswer(process.getInputStream());
        return result;
    }

    /* Converts the SAT output to a list, where each position has the
       color of the corresponding slot. Returns null, if no solution could
       be found */
    private int[] parseAnswer(InputStream file) throws IOException {
        BufferedReader in = new BufferedReader(new InputStreamReader(file));
        String line;
        int[] guess = new int[this.nSlots];
        int[] att;
        while ((line = in.readLine()) != null) {
            if (line.startsWith("s")) {
                if (line.contains("UNSATISFIABLE")) {
                    return null;
                }
            } else if (line.startsWith("v")) {
                for (String var : line.split(" ")) {
                    try {
                        Integer e = new Integer(var);
                        if (e.intValue() > 0) {
                            att = varToAtt(e);
                            guess[att[0]] = att[1];
                        }
                    } catch (NumberFormatException e) {
                        // Do nothing
                    }
                }
            }
        }
        return guess;
    }

    /* Converts the attribution of a color to a slot into a code which
       represents a literal/propositional variable */
    public Integer attToVar(int slot, int color) {
        return new Integer((color * this.nSlots) + slot + 1);
    }

    /* Converts a value in the SAT file to the corresponding attribution of
       color to a slot */
    public int[] varToAtt(Integer value) {
        int[] attribution = new int[2];
        attribution[0] = (value - 1) % this.nSlots;
        attribution[1] = (value - 1) / this.nSlots;
        return attribution;
    }
}
