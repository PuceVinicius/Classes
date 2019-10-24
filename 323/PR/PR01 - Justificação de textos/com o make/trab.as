EXTERN main
main         NOP           *os primeiros 29 registradores são usados como variáveis
start        IS    $0      *marca onde começa a leitura de cada linha
mem_counter  IS    $1      *itera pela memória para carregar cada caractere
spaces_total IS    $2      *usado para contar quantos espaços ocorreram na linha atual
char_total   IS    $3      *usado para contar quantos caracteres já se passaram na linha
col_max      IS    $4      *número máximo de colunas dado no argumento do programa
remainder    IS    $5
zero         IS    $6
counter      IS    $7      *contador usado para múltiplas situações
current_char IS    $8      *contador usado na seção "printer"
aux          IS    $9      *variável de auxílio usada múltiplas vezes
whitespace   IS    $10     *define um caractere de espaço para facilitar leitura
new_line     IS    $11     *define um caractere de nova linha para facilitar leitura
tab          IS    $12     *define um caractere de "tab" para facilitar leitura
aux3         IS    $13     *variável de auxílio usada múltiplas vezes
first_letter IS    $14     *usado para alterar "start"
extra        IS    $15     *número de espaços extras a serem colocados entre cada palavra na linha atual
last_letter  IS    $16     *final da última palavra da linha atual
aux4         IS    $17     *variável de auxílio usada múltiplas vezes
aux2         IS    $18     *variável de auxílio usada múltiplas vezes
plusOne      IS    $19     *número a partir do qual há um espaço a mais entre cada palavra
new_counter  IS    $20     *contador usado para múltiplas situações
last_counter IS    $21     *contador usado para múltiplas situações
A            IS    $22     *define o caractere "A" para facilitar leitura
Z            IS    $23     *define o caractere "Z" para facilitar leitura
a            IS    $24     *define o caractere "a" para facilitar leitura
z            IS    $25     *define o caractere "z" para facilitar leitura
dot          IS    $26     *define o caractere "." para facilitar leitura
flicker      IS    $27
car_ret      IS    $28     *define o caractere "carriage return" para facilitar leitura
             ADD   new_line,zero,#0A      *a seção a seguir define alguns registradores descritos acima
             ADD   whitespace,zero,#20
             ADD   tab,zero,#09
             SETW  car_ret,#0D
             SETW  A,#41
             SETW  Z,#5A
             SETW  a,#61
             SETW  z,#7A
             SETW  dot,#2E
             SUBU  col_max,rSP,32       *a seção a seguir salva o número C de colunas máximas no registrador col_max
             LDOU  col_max,col_max,0
col_loop1    ADD   aux,col_max,0
             DIV   col_max,col_max,16
             JZ    rR,col_loop1
             SETW  aux2,1
             ADD   aux4,aux,0
col_loop3    NOP
             DIV   aux4,aux4,16
             ADD   counter,counter,1
             JNZ   aux4,col_loop3
             DIV   counter,counter,2
             JZ    rR,3
             ADD   counter,counter,1
             MUL   aux,aux,16
             DIV   aux,aux,16
             MUL   aux3,aux2,rR
             ADD   col_max,aux3,0
             MUL   aux2,aux2,10
col_loop2    DIV   aux,aux,16
             DIV   aux,aux,16
             ADD   aux4,aux4,1
             MUL   aux3,aux2,rR
             ADD   col_max,col_max,aux3
             MUL   aux2,aux2,10
             CMP   remainder,counter,aux4
             JNZ   remainder,col_loop2
             SUB   remainder,remainder,remainder
             SUB   counter,counter,counter
             SUB   aux,aux,aux
             SUB   aux2,aux2,aux2
             SUB   aux3,aux3,aux3
             SETW  rX,1
             SETW  start,1000

readLoop     INT   #80              *loop de leitura da entrada padrão
             CMP   aux,rA,tab       *tabs e carriage returns são tratados como whitespaces
             JNZ   aux,2
             ADD   rA,whitespace,0
             CMP   aux,rA,car_ret
             JNZ   aux,2
             ADD   rA,whitespace,0
             CMP   aux,rA,whitespace
             JNZ   aux,nws              *nws = not whitespace
             SUB   aux2,counter,2       *garante que vários whitespaces seguidos são tratados como um só
             LDW   aux2,aux2,start
             CMP   aux2,aux2,whitespace
             JZ    aux2,readLoop
nws          STW   rA,counter,start
             ADD   counter,counter,2
             JP    rA,readLoop
             SETW  rX,2
             SUB   counter,counter,counter     *reseta o contador

mainLoop     LDW   rY,start,mem_counter        *loop de leitura da memória
             JN    rY,last_line                *detecta EoF
             CMP   aux,rY,dot                  *redireciona  o fluxo ao encontrar ponto final
             JNZ   aux,6
             ADD   last_letter,char_total,0
             ADD   aux2,mem_counter,2
             LDW   aux,aux2,start
             CMP   aux,aux,new_line
             JZ    aux,end_line               *função para tratar de pontos finais
             CMP   aux,rY,new_line            *detecta um caractere de nova linha não acompanhado de ponto
             JNZ   aux,3
             ADD   rY,whitespace,0            *trata o caractere como um whitespace em tal caso
             STW   rY,start,mem_counter
             ADD   char_total,char_total,1
             ADD   mem_counter,mem_counter,2
             CMP   aux,rY,whitespace          *detecta whitespace
             JNZ   aux,notSpace
             ADD   spaces_total,spaces_total,1
             SUB   last_letter,char_total,1   *define o último dígito da última palavra inteira da linha
             JMP   next_word                  *redireciona para função que encontra o início da próxima palavra
nw_ret       NOP                              *retorna da função "next_word"
notSpace     CMP   aux,char_total,col_max     *termina a leitura da linha se o número de caracteres chegar a C
             JZ    aux,setter                 *chama a função que definirá a qtde de espaços entre cada palavra
             JMP   mainLoop
returnSetter NOP                              *retorna da função "setter"
             JMP   printer                    *chama a função que imprimirá na saída padrão a linha justificada
             JMP   mainLoop

setter       NOP                              *função que calcula os espaços a serem colocados na linha
             LDW   aux,mem_counter,start      *encontra o próximo caractere no caso do atual ser o fim de uma palavra
             CMP   aux,whitespace,aux
             JZ    aux,2
             SUB   spaces_total,spaces_total,1
             JNZ   aux,4
             ADD   aux3,mem_counter,0
             DIV   last_letter,aux3,2        *muda last_letter e first_letter nesse caso
             ADD   first_letter,mem_counter,2
             JZ    spaces_total,big_word     *redireciona caso uma única palavra seja maior do que C
             SUB   aux,col_max,last_letter   *calcula diferença entre última letra e C
             DIV   extra,aux,spaces_total    *define espaços extras entre cada palavra
             ADD   remainder,rR,0
             SUB   plusOne,spaces_total,remainder     *define a partir de qual espaço se coloca um whitespace a mais

             SUB   spaces_total,spaces_total,spaces_total   *zera os registradores
             SUB   char_total,char_total,char_total
             JMP   returnSetter

printer      LDW   rY,start,counter         *função que imprime as linhas na saída padrão
             ADD   current_char,current_char,1
             ADD   counter,counter,2
             ADD   aux2,extra,1             *aux2 é usado para contar quantos whitespaces devem ser colocados
             CMP   aux3,spaces_total,plusOne    *verifica se já passou-se o ponto de colocar um espaço a mais
             JN    aux3,2
             ADD   aux2,aux2,1
             CMP   aux,rY,whitespace        *em caso de espaço, o loop a seguir imprime todos os espaços necessários
             JNZ   aux,notWS                *notWS = not whitespace
             ADD   spaces_total,spaces_total,1
space        SETW  rY,#5C
             INT   #80
             SETW  rY,#5F
             INT   #80
             SUB   aux2,aux2,1             *diminui aux2 a cada espaço colocado, termina quando aux2 chega a 0
             JP    aux2,space
             JMP   3
notWS        NOP
             INT   #80                     *imprime um caractere que não é whitespace
             CMP   aux2,current_char,last_letter
             JN    aux2,printer
             ADD   start,start,first_letter   *fim do loop, atualiza "start" para a linha seguinte
             SUB   counter,counter,counter    *zera os contadores
             SUB   spaces_total,spaces_total,spaces_total
             SUB   mem_counter,mem_counter,mem_counter
             SUB   current_char,current_char,current_char
             ADD   rY,new_line,0             *caractere de nova linha para encerrar a linha em si
             INT   #80
             JMP   mainLoop                  *retorno ao loop principal para pegar a próxima linha

next_word    MUL   aux,last_letter,2
nw_loop      LDW   aux2,aux,start            *função encontra caracteres após a última palavra inteira registrada
             JN    aux2,last_line            *as linhas a seguir definem se o caractere está entre 0-9, a-z ou A-Z
             ADD   aux,aux,2
             CMP   aux3,aux2,#30
             JN    aux3,next
             CMP   aux3,aux2,#39
             JNZ   aux3,notNext
             CMP   aux3,aux2,A
             JN    aux3,next
             CMP   aux3,aux2,Z
             JNZ   aux3,notNext
             CMP   aux3,aux2,a
             JN    aux3,next
             JMP   2                        *sai do loop se o caractere é uma letra ou número
next         JMP   nw_loop
notNext      NOP
             SUB   first_letter,aux,2       *salva o endereço do caractere como first_letter
             JZ    flicker,nw_ret           *"flicker" é uma switch usada para saber de onde o fluxo veio previamente,
             SETW  flicker,0                *pois isso altera a função de "next_word" (explicado na função end_line)
             ADD   start,start,first_letter
             SUB   spaces_total,spaces_total,spaces_total
             SUB   mem_counter,mem_counter,mem_counter
             SUB   char_total,char_total,char_total
             JMP   mainLoop

end_line    NOP                             *função chamada quando encontra-se um ponto final
            LDW   rY,start,new_counter
            ADD   new_counter,new_counter,2
            CMP   aux,rY,whitespace
            JNZ   aux,ws_cond               *"ws_cond" é a mesma condição de whitespace usada anteriormente
            SETW  rY,#5C
            INT   #80
            SETW  rY,#5F
ws_cond     INT   #80
            CMP   aux,rY,dot
            JNZ   aux,end_line
nl_loop     LDW   rY,new_counter,start     *loop para determinar se o ponto final encerra o arquivo e encontrar a próxima palavra
            JN    rY,end
            CMP   aux,rY,new_line
            JNZ   aux,4
            INT   #80
            ADD   new_counter,new_counter,2
            JMP   nl_loop
            SUB   new_counter,new_counter,new_counter
            SETW  flicker,1               *switch da função "next_word", zera contadores que só seriam zerados na função "printer"
            JMP   next_word

big_word    NOP                           *função para caso a palavra seja maior do que C
            LDW   rY,start,new_counter
            ADD   last_counter,last_counter,1
            ADD   new_counter,new_counter,2
            INT   #80
            CMP   aux,last_counter,last_letter
            JNP   aux,big_word
            ADD   rY,new_line,0
            INT   #80
            LDW   rY,start,new_counter
            JN    rY,end
            SUB   last_counter,last_counter,last_counter
            SUB   new_counter,new_counter,new_counter
            SETW  flicker,1             *imprime a palavra e chama "next_word" para a próxima linha
            JMP   next_word

last_line   NOP                         *caso se encontre o caractere EoF
            LDW   rY,start,new_counter
            JN    rY,end
            ADD   new_counter,new_counter,2
            CMP   aux,rY,whitespace
            JNZ   aux,ws_cond2          *mesma condição de whitespace
            SETW  rY,#5C
            INT   #80
            SETW  rY,#5F
ws_cond2    INT   #80
            JMP   last_line

end         INT   0
