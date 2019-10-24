Meu algoritmo satisfaz a condição de O(n log n)
comparações porque, diferentemente de um QuickSort3 
normal, utiliza-se do método de partição "ninther" 
de Tukey, que seria uma estratégia para diminuir 
significamente o número de comparações. Esta estratégia 
consiste na divisão do vetor grande em "outros menores" 
e no cálculo da mediana entre 3 números e, em seguida, 
no calculo da mediana entre os 3 ganhadores do cálculo 
passado (dentro do vetor menor). Assim, há uma aproximação 
desse "ninther" com a real metade da "parte menor" do vetor, 
fazendo com que a grande maioria dos "ninther" sejam
bons pivos, ajudando para diminuir ainda mais o número de
comparações realizada no algoritmo.