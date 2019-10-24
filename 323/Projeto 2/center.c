#include <stdio.h>
#include "buffer.h"
#include <ctype.h>

void printer(char arr[], size_t max, size_t start, size_t final) {
    for (int i = start; i < (final-max); i++) {
        printf("%d", arr[i]);
    }
    printf("\n");
}

int main(){

    char filename[1123];
    scanf("%s", filename);
    size_t c;
    scanf("%d", &c);

    int lastline = 0; //boolean pra condesar linhas vazia seguidas
    
    Buffer *b = buffer_create(c);
    char *pt = b->*data; //essa aqui

    while(read_line(filename, b) > 0){
        int spaceI = 0; //num de espacos iniciais
        int spaceF = 0; //num de espacos finais
        size_t startC = b -> p; //comeco de p, pra comparar com o numero de colunas pra ver se chegou no final da linha
        size_t finalC = b -> p + c;
        if ((sizeof(chr) / sizeof(chr[0])) > c) { //se o comeco e fim da linha forem != whitespace
            printer(chr, c, startC, finalC);
            fprintf(stderr, "line %zu: line too long", b -> buffer_size);
        }
        else {
            while(isspace(chr[startC]) != 0) { //comeca em p que seria a primeira casa que comecou a colocar chars
                if ((startC) == (startC + c)) {
                    lastline = 1;
                    break;
                }
                spaceI++;
                startC++; //anda em chr ate chegar no char != de whitespace
            }
            while(isspace(chr[finalC]) != 0) {
                if (lastline = 1) break;
                finalC--;
                spaceF++;
            }
            int spaceT = spaceI + spaceF;
            if ((spaceI + spaceF) > 0) {
                for (int i = 0; i < (spaceT/2); i++) {
                    printf(" ");
                }
                printer(chr, c, startC, finalC);
                for (int i = 0; i < (spaceT/2) + (spaceT%2); ++i)
                {
                    printf(" ");
                }
            }
            else printer(chr, c, startC, finalC);
        }
    }
}
