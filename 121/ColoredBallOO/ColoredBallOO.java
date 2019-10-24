/******************************************************************************
 *
 * MAC0121 - Algoritmos e Estruturas de Dados I
 * Aluno: Vinícius Moreno da Silva
 * Numero USP: 10297776
 * Variante do Web Exercise 1.5.39 (Elastic collisions)
 * Data: 29/08/2017
 * 
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

public class ColoredBallOO { 
    private double rx, ry;         // position
    private double vx, vy;         // velocity
    private final double radius;   // radius
    private final Color color;     // color

    // constructor
    public ColoredBallOO (Vector p, Vector v, double r, Color c) {
        rx = p.cartesian(0);
        ry = p.cartesian(1);
        setVel(v);
        radius = r;
        color = c;
    }

    public void updatePosition (double dt) {
        rx = rx + dt*vx;
        ry = ry + dt*vy;
    }

    public void treatWalls (double size, double dt) {
        //criacao de outro vector para checar colisao
        double[] vetorcheck = {Math.abs(rx + dt*vx), Math.abs(ry + dt*vy)};
        Vector check = new Vector(vetorcheck);
        if(check.cartesian(0) + radius > size) vx = -vx;
        if(check.cartesian(1) + radius > size) vy = -vy;
        if(check.cartesian(0) - radius < 0) vx = -vx;
        if(check.cartesian(1) - radius < 0) vy = -vy;
    }
   
    // move the ball one step
    public void move (double size, double dt) {
        treatWalls(size, dt);
        updatePosition(dt);
    }

    // draw the ball
    public void draw () { 
        StdDraw.setPenColor(color);
        StdDraw.filledCircle(rx, ry, radius);
    }

    public Vector vel () {
        double[] vetorvXY = {vx, vy};
        Vector vXY = new Vector(vetorvXY);
        return vXY;
    }

    public Vector pos () {
        double[] vetorrXY = {rx, ry};
        Vector rXY = new Vector(vetorrXY);
        return rXY;
    }

    public void setVel (Vector v) {
        vx = v.cartesian(0);
        vy = v.cartesian(1);
    }    

    public double radius () {
        return radius;
    }



    // test client
        public static void main(String[] args) {

        int n = Integer.parseInt(args[0]);
        int size = 512;
        ColoredBallOO[] Ball = new ColoredBallOO[n];

        for (int i = 0; i < n; i++){
            //position
            double[] local = {StdRandom.uniform(1, size - 1), StdRandom.uniform(1, size - 1)};
            Vector position = new Vector(local);
            //vel
            double[] velocidade = {StdRandom.uniform(-0.015, 0.015)*size, StdRandom.uniform(-0.015, 0.015)*size};
            Vector vel = new Vector(velocidade);
            //raio
            double raio = StdRandom.uniform(5, 8);
            //newColor
            Color newColor = Color.getHSBColor((float) StdRandom.uniform(0.0, 1.0), 0.8f, 0.8f);
            Ball[i] = new ColoredBallOO(position, vel, raio, newColor);
        }

        // animate them
        StdDraw.setXscale(0, size);
        StdDraw.setYscale(0, size);
        StdDraw.enableDoubleBuffering();
        while (true) {
            // move the n Balls
            for (int i = 0; i < n; i++) {
              for(int j = i + 1; j < n; j++){
                //colisões elásticas
                  if(Math.abs(Ball[i].pos().distanceTo(Ball[j].pos())) <= Ball[j].radius() + Ball[i].radius()){
                      Vector storage = Ball[j].vel();
                      Ball[j].setVel(Ball[i].vel());
                      Ball[i].setVel(storage);
                      break;
                  }
              }
              Ball[i].move(size, 1);
            }
            // draw the n Balls
            StdDraw.clear(StdDraw.BLACK);
            for (int i = 0; i < n; i++) {
                Ball[i].draw();
            }
            StdDraw.show();
            StdDraw.pause(20);
        }
    }
}
