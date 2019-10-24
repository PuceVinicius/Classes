import numpy as np
from ep3 import logistic_fit, logistic_predict
import matplotlib.pyplot as plt

N = 1000

mean_pos = [0, 0]
mean_neg = [4, 0]
cov = [
[1, 0],
[0, 1]
]

# Exemplos positivos
X_pos = np.random.multivariate_normal(mean_pos, cov, size = N//2)
Y_pos = np.zeros(N//2) + 1

# Exemplos negativos
X_neg = np.random.multivariate_normal(mean_neg, cov, size = N-N//2)
Y_neg = np.zeros(N-N//2) - 1

# Dataset completo
X = np.concatenate([X_pos, X_neg], axis = 0)
Y = np.concatenate([Y_pos, Y_neg], axis = 0)

# Embaralha os dados
perm = np.random.permutation(N)
X = X[perm]
Y = Y[perm]
# Descomente para visualizar

fit = logistic_fit(X, Y,None, None, 1e-2,1000, False)
final = logistic_predict(X, fit)

#vetor de previsoes
cor = []

for y in range(0,len(Y)):
    if Y[y] == 1 and final[y] > 0.5 or Y[y] == -1 and final[y] < 0.5 :
        cor.append('green') #previsoes batem
    else:
        cor.append('red') #previsao incorreta

plt.scatter(X[:,0], X[:,1], c=cor)
plt.show()
