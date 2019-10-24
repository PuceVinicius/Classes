A minha implementação de ipl() possui complexidade de
tempo O(N), com N sendo o número de nós na árvore, pois
a função ipl() passa somente uma vez em cada nó, garan-
tindo a linearidade. Seria sim possível fazer um bem 
melhor, no entanto como trabalhamos com ipl() somente
em BST.java, a melhor possibilidade seria linear.

As imagens geradas monstram a diferença entre as duas
funções delete(), uma degenerando a AB (BST.java) e a
outra fazendo a retirada totalmente aleatória, não de-
generando a AB (BSTsd.java). Conforme a árvore degenera-se
mais e mais, a linha preta vai se afastando da vermelha
(sem degeneração, com tamanho medio correto), o que não 
acontece nas imagens geradas com BSTsd.java.