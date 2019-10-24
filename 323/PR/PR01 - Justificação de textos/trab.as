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
counter_max  IS    $9
counter_dif  IS    $10
             SUBU  col_max,rSP,16
             SETW  rX,1
             SETW  start,100
loopOne      INT   #80
             STW   rA,start,counter
             ADD   counter,counter,1
             JP    rA,loopOne
             SETW  rX,2
             ADD   counter_max,counter,0
             SUB   counter,counter,counter
loopTwo      LDW   rY,start,counter
             INT   #80
             ADD   counter,counter,1
             SUB   counter_dif,counter_max,counter
             JNZ   rY,loopTwo
             INT   0