#include <ctype.h>
#include "buffer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
  return 0;
}

char chr[1123];
Buffer *buffer_create(size_t member_size){
    Buffer *b;
    b -> buffer_size = 0; //numero de linhas
    b -> member_size = member_size; //tamanho da linha
    b -> p = 0; //primeira posição livre no array
    b -> data = chr; //vetor de chars para cada linha
    return b;
}

void buffer_destroy(Buffer *B){
    free(B);
}

void buffer_reset(Buffer *B){
    memset(chr, 0, 1123);
    B -> data = chr;
}

void *buffer_push_back(Buffer *B){
    int increment = (int) B -> member_size;
    B -> p += increment;
}

int read_line(FILE *input, Buffer *B){
    int i = 0;
    char chars = fgetc(input);
    while(chars != '\n'){
        buffer_reset(B);
        if(chars < 0){
            if(i < 1)
                return 0;
            else
                break;
        }

        chr[i] = chars;
        chars = fgetc(input);
        i++;
    }
    chars = fgetc(input);
    if(chars == '\n'){
        i++;
        chr[i] = chars;
    }
    else
        ungetc(chars, input);
        
    return i;
}