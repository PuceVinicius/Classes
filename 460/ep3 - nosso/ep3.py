# all imports
import numpy as np
import matplotlib

#funcao sigmoid
def sigmoid(z):
    return 1 / (1 + np.exp(-z))

def logistic_fit( X, y, w = None, batch_size = None, learning_rate = 1e-2,
num_iterations = 1000, return_history = False ):
    ones = np.ones((len(X), 1))
    X = np.append(ones, X, axis=1)
    if w == None:
        w = np.random.rand(len(X[0]), 1)
        w = w * 2
        w = w - 1
        w = np.round(w)
    history = []
    #funcao de custo vetorizada adicionada ao vetor history
    history.append(1/len(y) * (-y.transpose()*np.log(sigmoid(np.dot(X, w))) - (1-y).transpose()*np.log(1 - sigmoid(np.dot(X, w)) ) ))
    if batch_size==None or batch_size > len(X) :
        batch_size = len(X)
    p = 0 #ponteiro para o batch
    for i in (0,num_iterations):
        #calculo vetorizado das derivadas para o gradiente

        #se estourar o indice
        if p + batch_size >= len(X) - 1:
            if batch_size < len(X):
                tempX = X[p:len(X)-1, :]
                tempY = y[p:len(X)-1]
                X = np.delete(X, np_s[p:len(X)], axis=0)
                Y = np.delete(Y, np_s[p:len(X)], axis=0)
                X = np.append(tempX, X, axis=0)
                Y = np.append(tempY, Y, axis=0)
            p = 0
        Xp = X[p:p+batch_size, :]
        yp = y[p:p+batch_size]

        z = np.dot(Xp, w)
        gradiente = np.sum(np.dot(Xp.transpose(), (sigmoid(z) - yp)) )/ len(yp)
        w = w - learning_rate*gradiente

        p = p + batch_size

        history.append(1/len(yp) * (-yp.transpose()*np.log(sigmoid(np.dot(Xp, w))) - (1-yp).transpose()*np.log(1 - sigmoid(np.dot(Xp, w)) ) ))

    if return_history == True:
        return history

    return w

def logistic_predict(X, w):
    ones = np.ones((len(X), 1))
    X = np.append(ones, X, axis=1)
    z = np.dot(X, w)

    return sigmoid(z)
