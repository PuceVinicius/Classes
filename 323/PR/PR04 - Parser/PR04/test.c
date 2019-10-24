#include "parse.h"

int main(){
  SymbolTable alias;
  alias = malloc(sizeof(SymbolTable));
  const char *line = "bla LDO $4,5,5\n";
  const char **errptr;
  Instruction **i;
  int fb = parse(*line, alias, **i, **errptr);
}
