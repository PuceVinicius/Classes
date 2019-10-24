#include <stdio.h>
#include "buffer.h"
#include <ctype.h>

void printer(char arr[], size_t start, size_t final, FILE *out) {
    for (int i = start; i < final; i++) {
        fprintf(out, "%c", arr[i]);
    }
}

int main() {
    char filename[112];
    char output[112];
    scanf("%s", &filename);
    scanf("%s", &output);
    FILE *p = fopen(filename, "r");
    FILE *out = fopen(output, "w");;
    size_t c;
    scanf("%zd", &c); //pega c da entrada

    int thisline = 0; //booleans pra condesar linhas vazias seguidas
    int lastline = 0; //
    
    Buffer *b = buffer_create(c);
    int ln = read_line(p, b); 
    int line = 1; //contador de linhas

    while(ln > 0) {
        size_t startC = 0; //comeco da linha
        size_t finalC = b->p-1; //final da linha, tinha o \n

        char *pointer = b -> data;
        char chr[b -> p+1];
        strncpy(chr, pointer, b -> p+1); //copia os chars para a array de char

        if (sizeof(chr) == 2) 
        	thisline = 1;
        
        while(isspace(chr[startC]) != 0) { //conta os espacos iniciais da palavra
            if (startC == finalC) {
                thisline = 1;
                break;
            }
            startC++;
        }
        while(isspace(chr[finalC]) != 0) { //conta os espacos finais da palavra
            if (startC == finalC) {
                thisline = 1;
                break;
            }
            finalC--;
        }
        if ((finalC - startC) > c) { //se o tamanho da linha (tirando espacos
                                     //iniciais e finais) for maior que c,
                                     //a linha é grande demais
            printer(chr, startC, finalC, out);
            fprintf(out, "\n");
            fprintf(stderr, "line %d: line too long\n", line);
        }
        else {
            int spaceT = c - (finalC - startC); //calcula quantos espacos terao
                                                //que ser colocados nas palavras
            if (!(lastline == 1 && thisline == 1)) {
	            if (spaceT > 0) {
	                for (int i = 0; i < (spaceT/2) + (spaceT%2); i++) {
	                    fprintf(out, " ");
	                }
	                printer(chr, startC, finalC, out);
	                for (int i = 0; i < (spaceT/2); ++i) {
	                    fprintf(out, " ");
	                }
	                fprintf(out, "\n");
	            }
	            else {
	                printer(chr, startC, finalC, out);
	                fprintf(out, "\n");
	            }
	        }
        }
        line++;
        ln = read_line(p, b);
        lastline = thisline;
        thisline = 0;
    }
    fclose(p);
    fclose(out);
}
