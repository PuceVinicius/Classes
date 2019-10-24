"""
  AO PREENCHER ESSE CABECALHO COM O MEU NOME E O MEU NUMERO USP,
  DECLARO QUE SOU A UNICA PESSOA AUTORA E RESPONSAVEL POR ESSE PROGRAMA.
  TODAS AS PARTES ORIGINAIS DESSE EXERCICIO PROGRAMA (EP) FORAM
  DESENVOLVIDAS E IMPLEMENTADAS POR MIM SEGUINDO AS INSTRUCOES
  DESSE EP E, PORTANTO, NAO CONSTITUEM ATO DE DESONESTIDADE ACADEMICA,
  FALTA DE ETICA OU PLAGIO.
  DECLARO TAMBEM QUE SOU A PESSOA RESPONSAVEL POR TODAS AS COPIAS
  DESSE PROGRAMA E QUE NAO DISTRIBUI OU FACILITEI A
  SUA DISTRIBUICAO. ESTOU CIENTE QUE OS CASOS DE PLAGIO E
  DESONESTIDADE ACADEMICA SERAO TRATADOS SEGUNDO OS CRITERIOS
  DIVULGADOS NA PAGINA DA DISCIPLINA.
  ENTENDO QUE EPS SEM ASSINATURA NAO SERAO CORRIGIDOS E,
  AINDA ASSIM, PODERAO SER PUNIDOS POR DESONESTIDADE ACADEMICA.

  Nome : Vini'cius Moreno da Silva
  NUSP : 10297776

  Referencias: Com excecao das rotinas fornecidas no enunciado
  e em sala de aula, caso voce tenha utilizado alguma referencia,
  liste-as abaixo para que o seu programa nao seja considerado
  plagio ou irregular.

  Exemplo:
  - O algoritmo Quicksort foi baseado em:
  https://pt.wikipedia.org/wiki/Quicksort
  http://www.ime.usp.br/~pf/algoritmos/aulas/quick.html
"""

import util

############################################################
# Part 1: Segmentation problem under a unigram model

class SegmentationProblem(util.Problem):
	def __init__(self, query, unigramCost):
		self.query = query
		self.unigramCost = unigramCost

	def isState(self, state):
		""" Metodo que implementa verificacao de estado """
		return state

	def initialState(self):
		""" Metodo que implementa retorno da posicao inicial """
		return self.query

	def actions(self, state):
		""" Metodo que implementa retorno da lista de acoes validas
		para um determinado estado
		"""
		actionsList = []
		for i in range(1, len(state)):
			actionsList.append(state[0:i])

		return actionsList

	def nextState(self, state, action):
		""" Metodo que implementa funcao de transicao """
		#if (self.unigramCost(state[len(action):]) > self.unigramCost(state[:len(action)])):
		return state[len(action):]
		#else:
		#	return state[:len(action)]

	def isGoalState(self, state):
		""" Metodo que implementa teste de meta """
		compState = self.unigramCost(state)
		for i in range(1, len(state)):
			if self.unigramCost(state[:i]) < compState:
				return False
		return True

	def stepCost(self, state, action):
		""" Metodo que implementa funcao custo """
		return self.unigramCost(state[:len(action)])

#state = palavra atual
#cost = cost ate' a palavra de state
#parent = pai da palavra, antes de ser quebrada
#action = onde quebrar a palavra


def segmentWords(query, unigramCost):

	if len(query) == 0:
		return ''
	 
	# BEGIN_YOUR_CODE 
	# Voce pode usar a função getSolution para recuperar a sua solução a partir do no meta
	# valid,solution  = util.getSolution(goalNode,problem)

	segProb = SegmentationProblem(query, unigramCost)
	segSol = util.uniformCostSearch(segProb)
	segBool, segStr = util.getSolution(segSol, segProb)

	return segStr + " " + segSol.state

	# END_YOUR_CODE

############################################################
# Part 2: Vowel insertion problem under a bigram cost

class VowelInsertionProblem(util.Problem):
	def __init__(self, queryWords, bigramCost, possibleFills):
		self.queryWords = queryWords
		self.bigramCost = bigramCost
		self.possibleFills = possibleFills

		self.queryList = queryWords.split('#')

		self.queryList.append(self.queryList[len(self.queryList)-1])

	def isState(self, state):
		""" Metodo  que implementa verificacao de estado """
		return state

	def initialState(self):
		""" Metodo  que implementa retorno da posicao inicial """
		ini = self.queryWords.split('#')
		return '-1' +'#'+ '-BEGIN-' +'#' +ini[0]

	def actions(self, state):
		""" Metodo  que implementa retorno da lista de acoes validas
		para um determinado estado
		"""
		vows = state.split('#')

		########pode dar pau

		vowsAct = []


		if (self.possibleFills(vows[2])):
			for i in self.possibleFills(vows[2]):
				act = int(vows[0]) + 1
				vowsAct.append(str(act) +'#'+ vows[1] +'#'+ i)
		else:
			act = int(vows[0]) + 1
			vowsAct.append(str(act) +'#'+ vows[1] +'#'+ vows[2])

		return vowsAct

	def nextState(self, state, action):
		""" Metodo que implementa funcao de transicao """
		acts = action.split('#')
		return acts[0] +'#'+ acts[2] +'#'+ self.queryList[int(acts[0])+1]

	def isGoalState(self, state):
		""" Metodo que implementa teste de meta """
		goal = state.split('#')
		if int(goal[0]) >= len(self.queryList)-2:
			return True

		return False

	def stepCost(self, state, action):
		""" Metodo que implementa funcao custo """
		cost = action.split('#')

		return self.bigramCost(cost[1], cost[2])





def insertVowels(queryWords, bigramCost, possibleFills):
	# BEGIN_YOUR_CODE 
	# Voce pode usar a função getSolution para recuperar a sua solução a partir do no meta
	# valid,solution  = util.getSolution(goalNode,problem)
	if not queryWords:
		return ''

	query = '#'.join(queryWords)

	vowProb = VowelInsertionProblem(query, bigramCost, possibleFills)
	vowSol = util.uniformCostSearch(vowProb)

	steps = []

	while vowSol.parent is not None:
		new_n = vowSol.parent
		if vowSol.state != vowProb.nextState(new_n.state, vowSol.action):
			return (False, steps)
		steps.append(vowSol.action)
		vowSol = new_n
	if vowSol is not None and vowSol.action is not None :
		steps.append(vowSol.action)
	steps = list(reversed(steps))

	condStr = True

	for i in steps:
		solut = i.split('#')
		if condStr:
			vowStr = solut[2]
			condStr = False
		else:
			vowStr = vowStr + ' ' + solut[2]
	return vowStr


	# END_YOUR_CODE

############################################################


def getRealCosts(corpus='corpus.txt'):

	""" Retorna as funcoes de custo unigrama, bigrama e possiveis fills obtidas a partir do corpus."""
	
	_realUnigramCost, _realBigramCost, _possibleFills = None, None, None
	if _realUnigramCost is None:
		print('Training language cost functions [corpus: '+ corpus+']... ')
		
		_realUnigramCost, _realBigramCost = util.makeLanguageModels(corpus)
		_possibleFills = util.makeInverseRemovalDictionary(corpus, 'aeiou')

		print('Done!')

	return _realUnigramCost, _realBigramCost, _possibleFills

def main():
	""" Voce pode/deve editar o main() para testar melhor sua implementacao.

	A titulo de exemplo, incluimos apenas algumas chamadas simples para
	lhe dar uma ideia de como instanciar e chamar suas funcoes.
	Descomente as linhas que julgar conveniente ou crie seus proprios testes.
	"""
	unigramCost, bigramCost, possibleFills  =  getRealCosts()
	
	#resulSegment = segmentWords('thisisnotmybeautifulhouse', unigramCost)
	#print(resulSegment)

	resultInsert = insertVowels(''.split(), bigramCost, possibleFills)
	print(resultInsert)

if __name__ == '__main__':
	main()
