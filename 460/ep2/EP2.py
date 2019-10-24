'''
	Vini'cius Moreno da Silva
	Nu'mero USP: 10297776
	MAC0460 - Machine Learning
'''
import numpy as np
from util import get_housing_prices_data


def normal_equation_weights(X, y):
	"""
	Calculates the weights of a linear function using the normal equation method.
	You should add into X a new column with 1s.

	:param X: design matrix
	:type X: np.ndarray(shape=(N, d))
	:param y: regression targets
	:type y: np.ndarray(shape=(N, 1))
	:return: weight vector
	:rtype: np.ndarray(shape=(d+1, 1))
	"""
	# START OF YOUR CODE:

	XOnes = np.ones((X.shape[0], 1), dtype=X.dtype)

	XNew = np.append(X, XOnes, axis=1)

	XTransp = np.transpose(XNew)

	w1 = XTransp.dot(XNew)
	w2 = np.linalg.inv(w1).dot(XTransp)
    
	# END YOUR CODE
	return w2.dot(y)

def normal_equation_prediction(X, w):
	"""
	Calculates the prediction over a set of observations X using the linear function
	characterized by the weight vector w.
	You should add into X a new column with 1s.

	:param X: design matrix
	:type X: np.ndarray(shape=(N, d))
	:param w: weight vector
	:type w: np.ndarray(shape=(d+1, 1))
	:param y: regression prediction
	:type y: np.ndarray(shape=(N, 1))
	"""
	
	# START OF YOUR CODE:

	XOnes = np.ones((X.shape[0], 1), dtype=X.dtype)

	XNew = np.append(X, XOnes, axis=1)

	prediction = np.empty([XNew.shape[0], 1])

	for i in range(0, XNew.shape[0]):
		prediction[i] = np.transpose(w).dot(XNew[i])

	# END YOUR CODE
	return prediction

def main():
	X, y = get_housing_prices_data(N=100)
	w = normal_equation_weights(X, y)
	prediction = normal_equation_prediction(X, w)
	print(y)
	print(prediction)

if __name__ == "__main__":
	main()
