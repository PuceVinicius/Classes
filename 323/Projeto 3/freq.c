#include <stdio.h>
#include "stable.h"
#include <ctype.h>

int main() {

	SymbolTable *st = stable_create();

	FILE *p = fopen(filename, "r");
	FILE *out = fopen(output, "w");
	int c; //char que esta sendo verificado
	int size = 0;
	char *str;

	if (pFile == NULL) perror ("Error opening file");
  	else {
  		while (c != EOF) {
    		c = fgetc (pFile);
    		if (!isblank(c)) {
    			size++;
    		}
    	}
    }
    fclose (pFile);
}