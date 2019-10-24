#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "buffer.c"
#include <math.h>
#include "parser.c"

char *current_line = 0;
int parse_result;
char *errptr = 0;
int contador = 0;

int assemble(const char *filename, FILE *input, FILE *output){
	//primeira etapa
	//ler todas as linhas e montar a lista

	//ACHEI Q TINHA ENTENDIDO QUAL SYMBOLTABLE FAZIA O QUE MAS NA VERDADE ME CONFUNDI, elas estao criadas mas não tenho certeza o que fazem direito
	//SymbolTable para rótulos definidos como "EXTERN"
	SymbolTable extern_table = stable_create();

	//SymbolTable para variaveis definidas pelo "IS"
	SymbolTable alias_table = stable_create();

	//SymbolTable para cada instrução
	SymbolTable label_table = stable_create();

	//Insertion result para ser usado ao longo desse bloco
	InsertionResult insertion;

	//Comeco da lista ligada de instrucoes e depois seu atualizador
	Instruction *instrucStart;

	Buffer *b = buffer_create(sizeof(char));

	while (read_line(input, b)) {
		current_line = b->data;
		const char **errptr = malloc(sizeof(const char **));
		Instruction **instr = malloc(sizeof(Instruction **));
		parse_result = parse(current_line, label_table, instr, errptr);

		if (parse_result == 1) {
			//INSTRUCOES QUE NAO GERAM CODIGO, OU SEJA, MAIS OU MENOS CORNER CASES
			//condicao para operator == "IS"
			Instruction instruc = **instr;
			if (strcmp(instruc.op->name, "IS") == 0) {
				insertion = stable_insert(alias_table, instruc.label);
				if (insertion.new == 0)
					printf("ERROR: Duplicate symbol\n");
				else {
					EntryData alias;
					alias.opd = instruc.opds[0];
					*(insertion.data) = alias;
				}
			}

			//condicao para operator == "EXTERN"
			else if (strcmp(instruc.op->name, "EXTERN") == 0) {
            	insertion = stable_insert(extern_table, instruc.label);
                if (insertion.new == 0)
                    printf("ERROR: Duplicate symbol\n");
                else {
                    EntryData ext;
                    ext.opd = instruc.opds[0];
                    *(insertion.data) = ext;
                }
            }
            else {
              		Instruction *instrucAt = instrucStart;
              		while (instrucAt != NULL)
  	 					      instrucAt = instrucAt->next;
            		  instruc = **instr;
            		  insertion = stable_insert(label_table, instruc.label);
            		  insertion.data->i = contador;
              		instrucAt->pos = contador++;
            }
        }
	}

  //gerar codigo-objeto

  while(instrucStart != NULL){
    int nomeOp = instrucStart->op->opcode;
    Operand *operandos[3];
    operandos[0] = instrucStart->opds[0];
    operandos[1] = instrucStart->opds[1];
    operandos[2] = instrucStart->opds[2];
    int op0 = atoi(operandos[0]->value.str);
    int op1 = atoi(operandos[1]->value.str);
    int op2 = atoi(operandos[2]->value.str);
    if(operandos[1]->value.str == NULL)
  		fprintf(output, "%d%d\n", nomeOp, (int) pow(2,16)*(op0));
  	else if(operandos[2]->value.str == NULL)
      	fprintf(output, "%d%d\n", nomeOp, (int) pow(2,16)*(op0) + (int) pow(2,8)*(op1));
  	else
      	fprintf(output, "%d%d\n", nomeOp, (int) pow(2,16)*(op0) + (int) pow(2,8)*(op1) + op2);
 	instrucStart = instrucStart->next;
  }
	return 0;
}
	//DEPOIS DAQUI, INSTRUCTION JA É UMA LISTA LIGADA DE TODAS AS INSTRUCOES CERTINHAS, ENTÃO É SÓ LER CADA UMA
	//E GERAR O CODIGO OBJETO DE CADA INSTRUCAO

int main(){
	char *entrada;
	char *saida;
	char *filename;

	scanf("%s", filename);
	scanf("%s", entrada);
	scanf("%s", saida);
	FILE *input = fopen(entrada, "r");
	FILE *output = fopen(saida, "w");

	if (assemble(filename, input, output) != 0)  {
		printf("assemble n deu erro caraioo");
	}
	else {
		printf("assemble deu erro em algum lugar :)");
		//aqui dentro tem que gerar as mensagens de erro. Tipos de erro? olha no paca, n sou seu empregado
	}
	fclose(input);
	fclose(output);
	return 0;
	//o output sera um codigo-objeto de nosso formato
}
