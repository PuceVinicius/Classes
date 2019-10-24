int main(){

    char filename[1123];
    scanf("%s", filename); //nao tenho certeza se ta certo

	Instruction **instr;					   //
  	SymbolTable alias_table = stable_create(); //frescuras pro parse rodar
  	const char **errptr;					   //
  
  	char *line = malloc (sizeof(char)); //nossa querida linha q eu vou dar mto malloc errado
  
  	int i = 0;
  	int count = 0; //contador de caracteres de cada linha
    while (filename[i] != EOF) { //iterar pelo arquivo inteiro, separando em linhas e mandando pro parse :)
    	if (filename[i] == '\n' || filename[i+1] == EOF) { //essa fita do EOF é pra nao ignorar a ultima linha
        	line = realloc (sizeof(char)*count); //isso aqui ta certo se pa
          	strncpy(line, filename, count); //copia os count primeiros caracteres de filename em line
          	int result = parse(line, alias_table, instr, errptr);
          	//printa a saida normal caso nao tenha erro no parse dessa linha
          	if (result != 0) {
            	printf("line     = %s\n", line);
              	if (instr -> label != NULL) {}
              		printf("label    = %s\n", instr -> label);
              	else
                  	printf("label    = n/a\n");
             	printf("operator = %s\n", instr -> op -> name);
              	printf("operands = ");
              	int j;
              
              	//esse bloco de bosta aqui é pra printar a linha do operands, com cada tipo possivel.
              	//esta incompleto/errado, as vezes nao é sempre q tem 3 operandos, e meu codigo só
              	//funciona se essa condicao for satisfeita. Dps a gente pensa em outra forma de fazer,
              	//mas o esqueletão do parse_test é esse aqui mesmo
              	for (j = 0; j < 2; j++) {
                  	if (instr -> opds[j] -> type == REGISTER)
                      	printf("Register(%d), ", instr -> opds[j] -> value);
                    else if (instr -> opds[j] -> type == LABEL)
                      	printf("Label(\"%s\"), ", instr -> opds[j] -> value);
                  	else if (instr -> opds[j] -> type == NUMBER_TYPE)
                      	printf("Number(%d), ", instr -> opds[j] -> value);
                  	else if (instr -> opds[j] -> type == STRING)
                      	printf("String(\"%s\"), ", instr -> opds[j] -> value);
                }
              	if (instr -> opds[2] -> type == REGISTER)
                    printf("Register(%d)", instr -> opds[2] -> value);
                else if (instr -> opds[2] -> type == LABEL)
                    printf("Label(\"%s\")", instr -> opds[2] -> value);
                else if (instr -> opds[2] -> type == NUMBER_TYPE)
                    printf("Number(%d)", instr -> opds[2] -> value);
                else if (instr -> opds[2] -> type == STRING)
                    printf("String(\"%s\")", instr -> opds[2] -> value);
              	printf("\n");
            }
          	else {
            	//aqui tem que printar o erro de cada coisa certinho, o que fode um pouco :)
            }
          	count = 0; //acabou a linha, joga no 0
          	i++;
        }
      else {
        count++;
        i++;
      }
    }
}
