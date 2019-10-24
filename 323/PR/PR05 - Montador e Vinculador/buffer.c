#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "buffer.h"

char* chr;
int tamanho;
Buffer *buffer_create(size_t member_size){
    Buffer *b;
    b = (Buffer *) malloc(member_size*sizeof(size_t));
    chr = (char *) malloc(member_size*sizeof(char));
    b -> buffer_size = sizeof(chr);
    b -> member_size = member_size;
    b -> p = 0; //primeira posição livre no array
    b -> data = chr; //vetor de chars para cada linha
    return b;
}

void buffer_destroy(Buffer *B){ //destroi o buffer
    free(B);
}

void buffer_reset(Buffer *B){ //reseta o vetor de chars e a quantidade de chars no ponteiro
    memset(chr, 0, B -> p + 1);
    B -> data = chr;
    B -> p = 0;
}

void *buffer_push_back(Buffer *B){ //atualiza a quantidade de chars e aplica resize se necessario no vetor
    B -> p += 1;
    tamanho = sizeof(chr)/sizeof(chr[0]);

    if(B -> p >= tamanho)
      chr = (char*) realloc(chr, 2*sizeof(char));

    return B;
}



int read_line(FILE *input, Buffer *B){
    int i = 0;
    buffer_reset(B);
    char chars = fgetc(input);
    while(chars != '\n'){
        if(chars < 0){
            if(i < 1)
                return 0;
            else{
                i++;
                chr[i] = '\n';
                buffer_push_back(B);
                break;
            }
        }
        chr[i] = chars;
        i++;
        buffer_push_back(B);
        chars = fgetc(input);
    }
    if(chars == '\n'){
        i++;
        buffer_push_back(B);
        chr[i] = '\n';
    }
    else{
        ungetc(chars, input);
    }

    return i;
}
