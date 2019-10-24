#include "parse.h"
#include "ctype.h"
#include <stdio.h>
#include "stdlib.h"
#include "stable.h"
#include <string.h>

const char  *errptr;

OperandType typeOfOperand(char *oper) {
  if (sizeof(oper) == 0) return OP_NONE; //TIREI O * DAQUI - se tiver o '*', vai ser um ponteiro, logo sempre com tamanho maior que 0 certo?
  if (oper[0] == '$')  return REGISTER;
  if (oper[0] == '-') return NEG_NUMBER;
  if (oper[0] == '\"' || oper[0] == '\'') return STRING;
  if ((sizeof(*oper)/sizeof(oper[0])) == 1) return BYTE1;
  if ((sizeof(*oper)/sizeof(oper[0])) == 2) return BYTE2;
  if ((sizeof(*oper)/sizeof(oper[0])) == 3) return BYTE3;
  if ((sizeof(*oper)/sizeof(oper[0])) == 4) return TETRABYTE;
  //AQUI NOVO - vê se a label é valida ou nao
  //
  //
  if (!(optable_find(oper) != NULL) && //desculpa por essa condicao, 4:30 da manha, to com preguiça de pensar
     (islower(oper[0]) || isupper(oper[0])) && //ve se o primeiro digito é uma letra (islower e isupper pega todas letras maiusculas e minusculas)
      oper[0] == '_') {
    int conditionLabel = 1;
    int indexL;
  	for (indexL = 0; indexL < strlen(oper); indexL++) { //itera sobre todos carac pra ver se são validos
      if (!isdigit(oper[indexL]) && !islower(oper[indexL]) &&
          !isupper(oper[indexL]) && !oper[indexL] == '_') {
        conditionLabel = 0; //condicao caso o caracter nao for um valido
      }
    }
    if (conditionLabel) return LABEL;
  }
  else {
    printf("SOLTA ERRO FALANDO QUE NÃO É UM LABEL DECENTE\n")
    return NULL;
  }
  //
  //
}

int parse (const char *s, SymbolTable alias_table, Instruction **instr, const char **errptr){
  
  Instruction *instruc;
  
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
  
  int i = 0;

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
  
  //array de strings de operandos (para o loop da linha 151)
  char *operanded[3];
  operanded[0] = operandP1;
  operanded[1] = operandP2;
  operanded[2] = operandP3;
  
  printf("Op1: %s\n", operandP1);
  printf("Op2: %s\n", operandP2);
  printf("Op3: %s\n", operandP3);

  //transforma os 3 operands em um vetor de OperandType
  OperandType oprdsType[3];
  oprdsType[0] = typeOfOperand(operandP1);
  oprdsType[1] = typeOfOperand(operandP2);
  oprdsType[2] = typeOfOperand(operandP3);
  operatorP = realloc(operatorP, sizeof(char)*strlen(operatorP)); // ISSO AQUI É NECESSARIO??? "reflita" enquanto eu durmo kkj
  
  //transforma as strings de operandos em um vetor de operandos
  Operand *opds[3];
  int index;
  for (index = 0; index < 3; index++) {
    if (oprdsType[index] == REGISTER)
    	opds[index] = *operand_create_register(unsigned char reg); //NAO TENHO CERTEZA CE TA CERTO, ENTAO VOU COLOCAR NADA
    else if (oprdsType[index] & NUMBER_TYPE)
   		opds[index] = *operand_create_number(octa num); //MESMA BOSTA
    else if (oprdsType[index] == LABEL)
    	opds[index] = *operand_create_label(operanded[index]);
    else if (oprdsType[index] == STRING)
    	opds[index] = *operand_create_string(operanded[index]);
    else opds[index] = NULL; //famoso operando NONE, não da erro aqui (a gente tinha falado antes q tinha q dar hihi)
  }

  //procura a ultima instrucao colocada
  instruc = &**instr;
 	while (instruc != NULL)
  	 instruc = instruc->next;
  
  //compara os operandos com o que o operador requer
  const Operator *baseOperator = optable_find(operatorP);
  printf("OpCode: %x\n", baseOperator->opd_types[2]);
  printf("OpString: %s\n", baseOperator->name);
  if ((baseOperator -> opd_types[0] & oprdsType[0]) &&
      (baseOperator -> opd_types[1] & oprdsType[1]) &&
      (baseOperator -> opd_types[2] & oprdsType[2])) {
    //AQUI NOVO -- adiciona na SymbolTable o label caso o operador seja "IS"
    //alem de colocar value (data) como o operando
    //
    //
    if (operatorP == "IS") {
      InsertionResult resultP = stable_insert(alias_table, opds[0]);
      if (resultP -> new == 0) printf("TEM Q SOLTAR ERRO DE REPETIDO NA SYMBOLTABLE\n")
      resultP -> data = operandsP;
    }
    //
    //
    instruc = *instr_create(labelP, baseOperator, opds);
    instr -> next = instruc;
    instruc -> lineno = instr -> lineno + 1; //ATUALIZA O CONTADOR DE LINHAS
    //NAO SEI O QUE FAZ COM O POS, ACHA PELO AMOR DE DEUS (edit1: dps de um tempo refletindo, em 
    //asmtypes.h diz q é o indice da instrucao no buffer, só q no buffer a gente tratava char, 
    //pensei em indice do char na string, mas n faz muito sentido)
    return 1;
  }
  else {
    printf("TEM Q SOLTAR ERRO DE OPERANDO OU O QUE FOR\n");
    //na moral que, pelo q eu entendi (5:20 da manha) esse codigo aqui (parse.c) nao tem q gritar
    //erros, e sim o parse_test.c, mas como eu estou com sono fritando provavelmente to errado
    return 0;
  }
  
}
int main(){
  SymbolTable alias;
  alias = stable_create();
  const char *line = "bla LDO $4,$5,5\n";
  const char **errptr;
  Instruction **i;
  int fb = parse(line, alias, i, errptr);
  printf("%d\n", fb);
  return 0;
}
