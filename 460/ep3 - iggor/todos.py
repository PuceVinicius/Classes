#//////////////////////////////////////////////////////////////////////////////////////
#Nome: Luis Hikaru Saito Silva, Iggor Francis Numata Mathews
#NUSP: respectivamente, 10297780, 10262572
#MAC0460 - Aprendizado de Máquina - ep3

#all imports
import numpy as np
import math
import matplotlib.pyplot as plt
#/////////////////////////////////////////////////////////////////////////////////////


def logistic_fit( X, y, w = None, batch_size = None, learning_rate = 1e-2, \
                 num_iterations = 1000, return_history = False ):
    N = X.shape[0] #definir N como tamanho da amostra

    X = np.concatenate((np.ones((X.shape[0], 1)), X), axis=1)
    history = np.ndarray(shape=(1,X.shape[1])) #array com o histórico w

    if batch_size == None or batch_size > N: #caso batch_size não seja recebido
        batch_size = N

    if w == None: #caso w seja None, inicializar com valores aleatórios
        w = np.ndarray(shape=(X.shape[1], 1))
        for wi in range(0, w.shape[0]):
            w[wi] = round(np.random.uniform(0, 1), 4)  #valores aleatórios de 0 a 1
        w[0] = 1
    history[0] = np.transpose(w)

    #atualizar o vetor w pelo número de vezes desejado
    for iter in range(0, num_iterations):
        grad_err = np.ndarray(shape=(X.shape[1], 1))
        batch_counter = 0 #contador auxiliar
        for i in range(0, N): #calcular o gradiente do erro
            Xi = X[i,:]
            batch_counter += 1
            pred = np.dot(np.transpose(w), Xi)
            for j in range(0, grad_err.shape[0]):
                grad_err[j] += ((y[i] - pred)*X[i,j]) #atualiza o gradiente de erro
                grad_err[j] = np.around(grad_err[j], 4)

            if batch_counter == batch_size: #atualiza w a cada (batch_size) amostras
                batch_counter = 0
                for j in range(0, grad_err.shape[0]):
                    grad_err[j] = grad_err[j]/batch_size

                for j in range(0, w.shape[0]):
                    w[j] = w[j] + (learning_rate*grad_err[j])
                    grad_err[j] = 0
                history = np.concatenate((history, np.transpose(w)))

        if batch_counter != 0: #caso N não seja múltiplo de batch_size
            grad_err = grad_err/batch_counter
            for j in range(0, w.shape[0]):
                w[j] = w[j] + (learning_rate*grad_err[j])

                grad_err[j] = 0
            history = np.concatenate((history, np.transpose(w)))

    if return_history == True: #histórico de iterações de w
        return w, history
    else: return w


def logistic_predict(X, w): #calcula a probabilidade de f(x) = 1 para todo x
    w = np.transpose(w)
    X = np.concatenate((np.ones((X.shape[0], 1)), X), axis=1)
    prediction = np.empty([X.shape[0], 1])
    for i in range(0, X.shape[0]):
        Xi = X[i,:]
        temp = np.dot(w, Xi)
        temp = 1/(math.exp(-temp) + 1) #sigmoid
        prediction[i] = temp

    return prediction


#função de teste para logistic_fit e logistic_predict
#majoritariamente feita pelo aluno Leonardo Blanger, que a disponibilizou no fórum de discussão
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

#teste das funções
w = logistic_fit( X, Y, w = None, batch_size = N, learning_rate = 1e-2, \
                  num_iterations = 100, return_history = False )
pred = logistic_predict(X, w)

#representação gráfica
#se Y = 1 e a prediction deu chance de mais de 50%, o ponto é azul (sucesso)
#se Y = -1 e a prediction deu chance de menos de 50%, o ponto é azul (sucesso)
#caso contrário, o ponto é vermelho (falha)
color = []
for i in range(0, Y.shape[0]):
    if (Y[i] > 0 and pred[i] > 0.50) or (Y[i] < 0 and pred[i] < 0.50):
        color.append('blue')
    else: color.append(('red'))
plt.scatter(X[:,0], X[:,1], c=color)
plt.show()
