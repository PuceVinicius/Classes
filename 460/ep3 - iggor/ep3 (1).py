#//////////////////////////////////////////////////////////////////////////////////////
#Nome: Luis Hikaru Saito Silva, Iggor Francis Numata Mathews
#NUSP: respectivamente, 10297780, 10262572
#MAC0460 - Aprendizado de Máquina - ep3

#all imports
import numpy as np
import math
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
