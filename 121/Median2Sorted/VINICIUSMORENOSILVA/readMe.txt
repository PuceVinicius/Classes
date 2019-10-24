o algoritmo funciona "limitando" os dois vetores usados, eliminando
parte dele caso não faça diferenca para a contagem késimo elemento
ou, se fizer diferença, fazendo um ajuste no contador de k. Essa
"limitação" é feita comparando a casa k/2 de cada vetor (a[k/2] com
b[k/2]) e, apartir disso, ver qual parte pode ser eliminada para sim-
plificação do problema. Na primeira vez, iria até k/2, na segunda, 
até k/4 e assim sucessivamente, ou seja, O(log n) onde n = a.length +
b.length