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
    w = np.random.rand(len(X[0]), 1)
    history = []
    #funcao de custo vetorizada adicionada ao vetor history
    history.append(1/len(y) * (-y.transpose()*np.log(sigmoid(np.dot(X, w))) - (1-y).transpose()*np.log(1 - sigmoid(np.dot(X, w)) ) ))
    if batch_size==None or batch_size > len(X)-1 :
        batch_size = len(X)

    for i in (0,num_iterations):
        #calculo vetorizado das derivadas para o gradiente
        z = np.dot(X, w)
        gradiente = np.dot(X.transpose(), (sigmoid(z) - y))/len(y)
        w = w - learning_rate*gradiente
        history.append(1/len(y) * (-y.transpose()*np.log(sigmoid(np.dot(X, w))) - (1-y).transpose()*np.log(1 - sigmoid(np.dot(X, w)) ) ))

    if return_history == True:
        return history

    return w

def logistic_predict(X, w):
    ones = np.ones((len(X), 1))
    X = np.append(ones, X, axis=1)
    z = np.dot(X, w)

    return sigmoid(z)
