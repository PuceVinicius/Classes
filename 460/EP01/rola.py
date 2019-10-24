# Escreva aqui o seu código do algoritmo PERCEPTRON
# Mostre ao menos um plot do resultado final (pontos, target e hipótese final)
# O entendimento do processo pode ser incrmentado com uma animação ou impressão de outras
# informações relacionadas ao processo de treinamento

import numpy as np
import matplotlib.pyplot as plt
import time

DELAY = 1

# calcula o valor da função w^T x, para um dado w e x
def valor_da_f(w, x):
	return(w.dot(x))
	
	
# calcula x2 tal que h(x) = w^T x = 0, x_1=-0.5,dx,2dx,...,1.5  (intervalo [-0.5,1.5])
def pontos_na_reta(w,dx):
	X1 = []
	X2 = []
	if w[2] != 0:
		x1 = -0.5
		while x1 <= 1.5:
			x2 = -(w[0] + w[1]*x1) / w[2]
			X1.append(x1)
			X2.append(x2)
			x1 = x1+dx
		return X1, X2
	else:  # supondo que w1 != 0
		x2 = -0.5
		while x2 <= 1.5: 
			X1.append(-w0/w1)
			X2.append(x2)
		return X1, X2
	
# devolve +1 se v é > 0 e -1 em caso contrário
def sign_da_f( v ):
	if (v > 0):
		return 1
	else:
		return -1

def incremento(i):
	if i == n:
		return 0
	else:
		return i
	
def plotando(w, Xe):
	X1, X2 = pontos_na_reta(w, 0.1)

	# mesmo plot acim, porém agora será plotada a hipótese e identificando
	# quais pontos estão sendo classificados errado por ela

	fig = plt.figure(figsize = (6,6))
	ax = fig.add_subplot(111)
	plt.ion()

	fig.show()
	fig.canvas.draw()

	# plota a reta chutada
	ax.plot(X1,X2,c="orange")

	# plota com 'o', vermelha ou azul, os pontos onde target e hipótese concordam
	# e com 'x' onde elas discordam
	colors = ["blue" if valor_da_f(wans, Xe[i,:])>0 else "red" for i in range(Xe.shape[0])]
	markers = ['o' if sign_da_f(valor_da_f(w, Xe[i,:]))==sign_da_f(valor_da_f(wans, Xe[i,:])) else 'x' for i in range(Xe.shape[0])]
	for _x, _y, _c, _m in zip(X[:,0], X[:,1], colors, markers):
		plt.scatter(_x, _y, marker=_m, color=_c)

	plt.xlim(-0.5, 1.5)
	plt.ylim(-0.5, 1.5)
	plt.xlabel("x1")
	plt.ylabel("x2")
	plt.title("h(x1,x2) = %.2f + %.2f*x1 + %.2f*x2" %(w[0],w[1],w[2]))
	
	fig.canvas.draw()
	time.sleep(DELAY)

	#time.sleep(0.5)

n = 4
corretos = 0
i = 0

signals = np.asarray([1, 1, -1, 1])

X = np.asarray([[0,0],[0,1],[1,0],[1,1]])
Xe = np.hstack(( np.ones((X.shape[0],1)), X ) )
wans = np.asarray([0.5, -1, 2])
w = np.asarray([-0.5, 1 , 1])

#plotando(w, Xe)

while(corretos < n):
	if signals[i] > 0 and sign_da_f(valor_da_f(w, Xe[i])) < 0:
		plotando(w, Xe)
		w = w + Xe[i]
		corretos = 0
		i += 1
		i = incremento(i)
	elif signals[i] < 0 and sign_da_f(valor_da_f(w, Xe[i])) > 0:
		plotando(w, Xe)
		w = w - Xe[i]
		corretos = 0
		i += 1
		i = incremento(i)
	else :
		corretos += 1
		i += 1
		i = incremento(i)
plotando(w, Xe)