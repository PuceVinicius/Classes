/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Tarefa: Variante do Creative Ex. 3.1.33 (Color study)
 * Data: 15/08/2017
 * 
 * Baseado em HSB.java
 *
 * DECLARO QUE SOU O ÚNICO AUTOR E RESPONSÁVEL POR ESTE PROGRAMA.  TODAS AS 
 * PARTES DO PROGRAMA, EXCETO AS QUE SÃO BASEADAS EM MATERIAL FORNECIDO  
 * PELO PROFESSOR OU COPIADAS DO LIVRO OU DAS BIBLIOTECAS DE SEDGEWICK & WAYNE, 
 * FORAM DESENVOLVIDAS POR MIM.  DECLARO TAMBÉM QUE SOU RESPONSÁVEL POR TODAS 
 * AS CÓPIAS DESTE PROGRAMA E QUE NÃO DISTRIBUÍ NEM FACILITEI A DISTRIBUIÇÃO
 * DE CÓPIAS DESTA PROGRAMA.
 *
 ******************************************************************************/

import java.awt.Color;

public class ColorStudyH {  
    public static void main(String[] args) {
        StdDraw.setXscale(-1, 16);
        StdDraw.setYscale(-1, 16);
        float h1 = Float.parseFloat(args[0]);
        float h2 = Float.parseFloat(args[1]);
        for (int i = 0; i < 16; i++) {
            for (int j = 0; j < 16; j++) {
                int gray = i*16 + 15;
                float coord = (float)(Math.sqrt(i*i + j*j));
                float hif = coord/(15*(float)(Math.sqrt(2)));
                float hueFinal = (1-hif)*h1 + hif*h2;
                Color c1 = Color.getHSBColor(hueFinal, .95f, .95f);
                Color c2 = new Color(gray, gray, gray);
                StdDraw.setPenColor(c1);
                StdDraw.filledSquare(i, j, 0.5);
                StdDraw.setPenColor(c2);
                StdDraw.filledSquare(i, j, 0.25);
            }
        }
        StdDraw.save("study" + "-" + h1 + "-" + h2 + ".png");
    }
}