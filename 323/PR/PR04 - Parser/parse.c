#include "parse.h"
#include "ctype.h"
#include <stdio.h>
#include "stdlib.h"
#include "stable.h"
#include <string.h>

const char  *errptr;

//s --> linha
//

OperandType typeOfOperand(char *oper) {
  if (sizeof(*oper) == 0) return OP_NONE;
  if (oper[0] == '$')  return REGISTER;
  if (oper[0] == '-') return NEG_NUMBER;
  if (oper[0] == '\"' || oper[0] == '\'') return STRING;
  if ((sizeof(*oper)/sizeof(oper[0])) == 1) return BYTE1;
  if ((sizeof(*oper)/sizeof(oper[0])) == 2) return BYTE2;
  if ((sizeof(*oper)/sizeof(oper[0])) == 3) return BYTE3;
  if ((sizeof(*oper)/sizeof(oper[0])) == 4) return TETRABYTE;
  return LABEL;
}

int parse (const char *s, SymbolTable alias_table, Instruction **instr, const char **errptr) {
  Instruction *instruc;
  int i = 0;
  // label(opcional)   operator   operando1,operando2,operando3 (opcional)

  //cada componente do comando junto de seu indice
  char *labelP;
  labelP = malloc(sizeof(strlen(s)*sizeof(char)));
  int la = 0;

  char *operatorP;
  operatorP = malloc(sizeof(strlen(s)*sizeof(char)));
  int oprt = -1;

  char *operandsP;
  operandsP = malloc(sizeof(strlen(s)*sizeof(char)));
  int oprd = -1;

  Operand *opds;
  //lê cada caracter da string "s", adicionando-o em seu respectivo componente.
  while (s[i] != '\n' && s[i] != EOF) {
    //enquanto o indice do proximo componente for menor que 0, adiciona-se
    //o caracter no componente atual
    if (!isspace(s[i])) {
      if (s[i] == '*') break;
      else if (oprt < 0) {
        labelP[la] = s[i];
        la++;
      }
      else if (oprd < 0) {
        operatorP[oprt] = s[i];
        oprt++;
      }
      else {
        operandsP[oprd] = s[i];
        oprd++;
      }
    }
    else {
      //troca o indice do proximo componente
      if (la != 0 && oprt < 0) oprt = 0;
      else if (oprt != 0 && oprd < 0) oprd = 0;
    }
    i++;
  }
  //caso só tenha 2 componentes, troque-os para que label fique nula
  if (oprd <= 0) {
    operandsP = operatorP;
    operatorP = labelP;
    labelP = NULL;
  }

  //transforma operandsP em 3 operands
  char *operandP1;
  operandP1 = malloc(sizeof(strlen(operandsP)*sizeof(char)));
  char *operandP2;
  operandP2 = malloc(sizeof(strlen(operandsP)*sizeof(char)));
  char *operandP3;
  operandP3 = malloc(sizeof(strlen(operandsP)*sizeof(char)));
  int oprd1 = 0;
  int oprd2 = -1;
  int oprd3 = -1;
  int j = 0;
  while (j < strlen(operandsP)) {
    if (operandsP[j] != ',') {
      if (oprd2 < 0) {
        operandP1[oprd1] = operandsP[j];
        oprd1++;
      }
      else if (oprd3 < 0) {
        operandP2[oprd2] = operandsP[j];
        oprd2++;
      }
      else {
        operandP3[oprd3] = operandsP[j];
        oprd3++;
      }
    }
    else {
      //troca o indice do proximo componente
      if (oprd1 != 0 && oprd2 < 0) oprd2 = 0;
      else if (oprd2 != 0 && oprd3 < 0) oprd3 = 0;
    }
    j++;
  }
  printf("Op1: %s\n", operandP1);
  printf("Op2: %s\n", operandP2);
  printf("Op3: %s\n", operandP3);

  //transforma os 3 operands em um vetor de OperandType

  OperandType oprdsType[3];
  oprdsType[0] = typeOfOperand(operandP1);
  oprdsType[1] = typeOfOperand(operandP2);
  oprdsType[2] = typeOfOperand(operandP3);

  //compara os operandos com o que o operador requer
  char *rola = "LDO";
  const Operator *baseOperator = optable_find(rola);
  printf("OpCode: %x\n", baseOperator->opd_types[2]);
  printf("OpString: %s\n", baseOperator->name);
  if ((baseOperator -> opd_types[0] & oprdsType[0]) &&
      (baseOperator -> opd_types[1] & oprdsType[1]) &&
      (baseOperator -> opd_types[2] & oprdsType[2])) {
    //ADICIONA INSTRUCAO NA LISTA
    return 1;
  }
  else {
    //SOLTA O ERRO
    return 0;
  }


  //percorre ate o ultimo node
  instruc = &**instr;
  while (instr != NULL)
     instruc = instruc->next;

  /*atualiza os dados dos nodes
  instruc->label = labelP;
  Operator *o;
  *o = optable_find(operatorP);
  instruc->op = o;
  //instruc->opds = opds;

  //associar os operadores aos operandos
  //InsertionResult result = stable_insert(alias_table, operator);
  //result.data -> opds;*/
}
int main() {
  SymbolTable alias;
  alias = stable_create();
  const char *line = "bla LDO $4,$5,5\n";
  const char **errptr;
  Instruction **i;
  int fb = parse(line, alias, i, errptr);
  printf("%d\n", fb);
  return 0;
}
