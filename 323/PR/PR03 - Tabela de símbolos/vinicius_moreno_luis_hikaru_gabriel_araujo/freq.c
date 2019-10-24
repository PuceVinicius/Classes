#include <stdio.h>
#include "stable.h"
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int maxsize;  //tamanho da maior palavra
char **words; //array de strings
int nOfWords; //numero de palavras diferentes
int counter;  //contador para o número de keys que foram pegas da função visit

int visit(const char *key, EntryData *data) {
    words[counter] = key; //salva a key no vetor
    counter += 1; //aumenta o índice do vetor
    return 1;
}

void insertionSort (char **word, int size) { //algoritmo de insertionSort
  char *key;
  for (int i = 1; i < size; i++) {
    key = word[i];
    int j = i-1;
    while(j >= 0 && strcmp(word[j], key) > 0) {
      words[j+1] = words[j];
      j--;
    }
    words[j+1] = key;
  }
}

int main(int argc, char* argv []) {
  maxsize = 0;
  nOfWords = 0;

  FILE *p;
  p = fopen(argv[1], "r"); //abre o arquivo para leitura
  char c; //char que esta sendo verificado
  int size = 0; //tamanho da string
  char *str; //string que esta sendo verificada
  InsertionResult base; //resultado da insercao
  SymbolTable st = stable_create(); //symboltable

  if(p == NULL) perror ("Error opening file"); //erro caso o arquivo seja NULL
  else {
    str = malloc(sizeof(c)); //cria espaco de memoria pra string de um caracter
    while(c != EOF) { //itera ate chegar no final do arquivo
      c = (char)fgetc (p); //
      if(!isspace(c) && c != EOF) { //pegar uma palavra e seu tamanho
        str = realloc(str, (sizeof(str) + sizeof(c))); //arruma o espaco
                            //para mais um caracter
        str[size] = c;
        size++;
      }
      else {  //se o caracter for espaço e o tamanho da string maior que 0,
            //insere a string na symboltable, tambem aumentando o numero de
            //palavras contida na symboltable
        if(size > 0) {
          base = stable_insert(st, str);

          if (base.new == 0){
            base.data -> i += 1;

          }
          else{
            nOfWords += 1;
            if(size > maxsize)
            maxsize = size;
            base.data -> i = 1;
          }
          size = 0;
          str = (char*) malloc(sizeof(c));
        }
      }
    }
  }
  fclose (p);
  int (*func)(const char *key, EntryData *data);
  func = visit;
  words = malloc(nOfWords*(sizeof(char *))); //inicia o vetor que irá guardar as 
                                              //palavras diferentes
  int i = stable_visit(st, *func); //itera pela symbol table
  int size2 = sizeof(words)/sizeof(words[0]);

  insertionSort(words, nOfWords); //ordena o vetor
  int k;
  for(k = 0; k < nOfWords; k++){ //itera pelo vetor ordenado
    EntryData *ed;
    ed = stable_find(st, words[k]); //pega o valor da chave, ou seja, sua frequênci
    int val = ed->i;
    printf("%s", words[k]);
    int j;
    for(j = strlen(words[k]); j <= maxsize; j++){
      printf(" ");
    }
    printf("%d\n",ed->i);
  }
}

