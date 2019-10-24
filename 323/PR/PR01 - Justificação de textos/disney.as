EXTERN main
main         ADDU  $1,$1,1
start        IS    $0
carac_total  IS    $1
word_total   IS    $2
last_ws      IS    $3
col_max      IS    $4
remainder    IS    $5
extra_ws     IS    $6
counter      IS    $7
current_char IS    $8
             SUBU  col_max,rSP,16
             SETW  rX,1
             SETW  start,1000
loop         INT   #80
             ADD   $10,counter,start
             SAVE  $10,rA,rA
             SETW  rX,2
             ADD   rY,$10,0
             INT   #80
             SETW  rX,1
             ADD   counter,$9,1
             JP    rA,loop
             SUB   counter,counter,counter
             SETW  rX,2
other_loop   LDWU   current_char,counter,start
             ADD    rY,current_char,0
             INT   #80
             ADD   counter,$9,1
             JP    current_char,other_loop
             INT   0