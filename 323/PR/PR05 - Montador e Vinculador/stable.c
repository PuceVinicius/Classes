#include <stdlib.h>
#include "stable.h"
#include <string.h>
#include <stdio.h>

typedef struct node{
  const char *key;
  EntryData data;
  struct node *next;
}Node;

struct stable_s{
  int size; //tamanho da hash table
  Node *s; //array da hash table
};

Node *tabela;
int tamanho;

int hashCode(const char *key) {
  int h = 0, a = 127;
     for (; *key != 0; key++)
       h = (a*h + *key) % 97;
     return h;
}

SymbolTable stable_create(){
  SymbolTable st;
  tabela = malloc (97*sizeof(Node));
  st = malloc (sizeof(tabela)+sizeof(tamanho));
  st -> s = tabela;
  st -> size = tamanho;
  tamanho = 0;
  return st;
}

void stable_destroy(SymbolTable table){
	free(table);
}

InsertionResult stable_insert(SymbolTable table, const char *key){
  InsertionResult *result = malloc(sizeof(InsertionResult));
  int hash = hashCode(key)%97;	//vamos utilizar hash modular TOP
  if(tabela[hash].key == NULL){		//sem keys na posiC'ao [hash] do vetor
      tabela[hash].key = key;
      result->new = 1;
      result->data = &tabela[hash].data;
      tamanho += 1;
  }
  else{	//com keys na posiC'ao [hash] do vetor
        Node *n;
        n = &tabela[hash];
        if(strcmp(n->key, key) == 0){	//caso jC! tenha a key na symboltable
            result->new = 0;
            result->data = &n->data; //ponteiro de value do Node apontado para o data type que vai receber o input
            InsertionResult is;
            is = *result;
            return *result;
        }
        while(n->next != NULL){
          if(strcmp(n->key, key) == 0){	//caso jC! tenha a key na symboltable
            result->new = 0;
            result->data = &n->data; //ponteiro de value do Node apontado para o data type que vai receber o input
            return *result;
          }
          Node *nn;
          nn = n->next;
          n = nn;
        }
        Node *t = malloc(sizeof(Node));
        t->key = key;
        n->next = t;
        result->new = 1;
        result->data = &t->data;
        tamanho += 1;
  }
  table -> size = tamanho;
  table -> s = tabela;
  return *result;
}

EntryData *stable_find(SymbolTable table, const char *key){
  int hash = hashCode(key)%97;
  EntryData *ret = malloc(sizeof(EntryData));
  if(tabela[hash].key == NULL){		//sem keys na posiC'ao [hash] do vetor
    return ret;
  }
  else{	//com keys na posiC'ao [hash] do vetor
        Node *n;
        n = &tabela[hash];
        if(strcmp(n->key, key) == 0){	//caso jC! tenha a key na symboltable
            ret = &n->data;
            return ret;
          }
        while(n != NULL){
          if(strcmp(n->key, key) == 0){	//caso jC! tenha a key na symboltable
            ret = &n->data;
            return ret;
          }
          Node *nn;
          nn = n->next;
          n = nn;
        }
        return ret;
  }
}

int stable_visit(SymbolTable table,
                 int (*visit)(const char *key, EntryData *data)){
  int i;
  for(i = 0; i < 97; i++){
    if(tabela[i].key != NULL){
      Node *n;
      n = &tabela[i];
      EntryData *ed;
      ed = &n->data;
      int ext = ( *visit)(n->key, ed);
      if(ext == 0)
        return 0;

      while(n->next != NULL){
        //Node *nn;
        *n = *n->next;
       // n = nn;
        EntryData *ed;
        ed = &n->data;
        int ext = (*visit)(n->key, ed);
        if(ext == 0)
            return 0;
      }
    }
  }
   return 1;
}
