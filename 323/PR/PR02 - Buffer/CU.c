#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include "buffer.c"

int main(){
  Buffer *b = buffer_create(sizeof(char));
  FILE *p = fopen("foo.txt", "r");
  while(read_line(p, b) > 0){
    char *pointer = b -> data;
    char printa[b -> p];
    //printf("%d", b -> p);
    strncpy(printa, pointer, b -> p);
    printf("%s\n", printa);
  }
  printf("\n");
}
