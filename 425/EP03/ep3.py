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

  Nome : Vinicius Moreno da Silva
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

import math
import random
from collections import defaultdict
import util


# **********************************************************
# **            PART 01 Modeling BlackJack                **
# **********************************************************


class BlackjackMDP(util.MDP):
    """
    The BlackjackMDP class is a subclass of MDP that models the BlackJack game as a MDP
    """
    def __init__(self, cardValues, multiplicity, threshold, peekCost):
        """
        cardValues: list of integers (face values for each card included in the deck)
        multiplicity: single integer representing the number of cards with each face value
        threshold: maximum number of points (i.e. sum of card values in hand) before going bust
        peekCost: how much it costs to peek at the next card
        """
        self.cardValues = cardValues
        self.multiplicity = multiplicity
        self.threshold = threshold
        self.peekCost = peekCost

    def startState(self):
        """
         Return the start state.
         Each state is a tuple with 3 elements:
           -- The first element of the tuple is the sum of the cards in the player's hand.
           -- If the player's last action was to peek, the second element is the index
              (not the face value) of the next card that will be drawn; otherwise, the
              second element is None.
           -- The third element is a tuple giving counts for each of the cards remaining
              in the deck, or None if the deck is empty or the game is over (e.g. when
              the user quits or goes bust).
        """
        return (0, None, (self.multiplicity,) * len(self.cardValues))

    def actions(self, state):
        """
        Return set of actions possible from |state|.
        You do not must to modify this function.
        """
        return ['Take', 'Peek', 'Quit']

    def succAndProbReward(self, state, action):
        """
        Given a |state| and |action|, return a list of (newState, prob, reward) tuples
        corresponding to the states reachable from |state| when taking |action|.
        A few reminders:
         * Indicate a terminal state (after quitting, busting, or running out of cards)
           by setting the deck to None.
         * If |state| is an end state, you should return an empty list [].
         * When the probability is 0 for a transition to a particular new state,
           don't include that state in the list returned by succAndProbReward.
        """
        total = state[0]
        peeked_card = state[1]
        deck = state[2]

        result = []

        if deck is None:
            return []

        total_cards = 0
        for i in deck:
            total_cards = total_cards + i

        if action == 'Take':
            if peeked_card is not None:
                deck_act = list(deck)
                deck_act[peeked_card] = deck_act[peeked_card] - 1
                total_act = total + self.cardValues[peeked_card]
                if total_act > self.threshold: #caso que a carta estourou o maximo
                    state_act = (total_act, None, None)
                    result.append((state_act, 1, 0))
                else:
                    is_deck_empty = True
                    for j in range(len(deck_act)):
                        if deck_act[j] > 0:
                            is_deck_empty = False
                            break
                    if is_deck_empty: #caso que puxa a ultima carta do baralho
                        state_act = (total_act, None, None)
                        result.append((state_act, 1, total_act))
                    else: #puxa carta e nao estoura
                        state_act = (total_act, None, tuple(deck_act))
                        result.append((state_act, 1, 0))

            else:
                for i in range(len(deck)):
                    if deck[i] > 0:
                        deck_act = list(deck)
                        deck_act[i] = deck_act[i] - 1
                        total_act = total + self.cardValues[i]
                        if total_act > self.threshold: #caso que a carta estourou o maximo
                            state_act = (total_act, None, None)
                            result.append((state_act, (deck_act[i]+1)/total_cards, 0))
                        else:
                            is_deck_empty = True
                            for j in range(len(deck_act)):
                                if deck_act[j] > 0:
                                    is_deck_empty = False
                                    break
                            if is_deck_empty: #caso que puxa a ultima carta do baralho
                                state_act = (total_act, None, None)
                                result.append((state_act, (deck_act[i]+1)/total_cards, total_act))
                            else: #puxa carta e nao estoura
                                state_act = (total_act, None, tuple(deck_act))
                                result.append((state_act, (deck_act[i]+1)/total_cards, 0))

        if action == 'Peek':
            for i in range(0, len(deck)):
                if deck[i] > 0:
                    state_act = (total, i, deck)
                    result.append((state_act, deck[i]/total_cards, -self.peekCost))

        if action == 'Quit':
            state_act = (total, None, None)
            result.append((state_act, 1, total))

        return result
        # END_YOUR_CODE

    def discount(self):
        """
        Return the descount that is 1
        """
        return 1

# **********************************************************
# **                    PART 02 Value Iteration           **
# **********************************************************

class ValueIteration(util.MDPAlgorithm):
    """ Asynchronous Value iteration algorithm """
    def __init__(self):
        self.pi = {}
        self.V = {}

    def solve(self, mdp, epsilon=0.001):
        """
        Solve the MDP using value iteration.  Your solve() method must set
        - self.V to the dictionary mapping states to optimal values
        - self.pi to the dictionary mapping states to an optimal action
        Note: epsilon is the error tolerance: you should stop value iteration when
        all of the values change by less than epsilon.
        The ValueIteration class is a subclass of util.MDPAlgorithm (see util.py).
        """
        mdp.computeStates()
        def computeQ(mdp, V, state, action):
            # Return Q(state, action) based on V(state).
            return sum(prob * (reward + mdp.discount() * V[newState]) \
                            for newState, prob, reward in mdp.succAndProbReward(state, action))

        def computeOptimalPolicy(mdp, V):
            # Return the optimal policy given the values V.
            pi = {}
            for state in mdp.states:
                pi[state] = max((computeQ(mdp, V, state, action), action) for action in mdp.actions(state))[1]
            return pi
        V = defaultdict(float)  # state -> value of state
        # Implement the main loop of Asynchronous Value Iteration Here:
        '''
        Each state is a tuple with 3 elements: total, peakIndex e deck
        Given a |state| and |action|, return a list of (newState, prob, reward) tuples
        '''

        for stat in mdp.states:
            V[stat] = 0.0

        omega = float('inf')
        while omega > epsilon:
            new_omega = float('-inf')
            for stat in mdp.states:
                biggest_v = float('-inf')
                base = V[stat]
                for act in mdp.actions(stat):
                    acts_v = mdp.succAndProbReward(stat, act)
                    transition_act = 0.0
                    r_act = 0.0
                    for tuples in acts_v:
                        transition_act = transition_act + tuples[1]*V[tuples[0]]
                        r_act = r_act + tuples[1]*tuples[2]
                    transition_act = transition_act*mdp.discount()

                    if transition_act + r_act > biggest_v:
                        biggest_v = transition_act + r_act

                V[stat] = biggest_v

                #calcula a variacao maxima da iteracao e tira o minimo com omega
                if new_omega < abs(base - V[stat]):
                    new_omega = abs(base - V[stat])

                omega = min(omega, new_omega)


        # Extract the optimal policy now
        pi = computeOptimalPolicy(mdp, V)
        # print("ValueIteration: %d iterations" % numIters)
        self.pi = pi
        self.V = V

# First MDP
MDP1 = BlackjackMDP(cardValues=[1, 5], multiplicity=2, threshold=10, peekCost=1)

# Second MDP
MDP2 = BlackjackMDP(cardValues=[1, 5], multiplicity=2, threshold=15, peekCost=1)

def peekingMDP():
    """
    Return an instance of BlackjackMDP where peeking is the
    optimal action for at least 10% of the states.
    """
    # BEGIN_YOUR_CODE
    return(BlackjackMDP(cardValues=[20, 200], multiplicity=5, threshold=60, peekCost=1))
    # END_YOUR_CODE


# **********************************************************
# **                    PART 03 Q-Learning                **
# **********************************************************

class QLearningAlgorithm(util.RLAlgorithm):
    """
    Performs Q-learning.  Read util.RLAlgorithm for more information.
    actions: a function that takes a state and returns a list of actions.
    discount: a number between 0 and 1, which determines the discount factor
    featureExtractor: a function that takes a state and action and returns a
    list of (feature name, feature value) pairs.
    explorationProb: the epsilon value indicating how frequently the policy
    returns a random action
    """
    def __init__(self, actions, discount, featureExtractor, explorationProb=0.2):
        self.actions = actions
        self.discount = discount
        self.featureExtractor = featureExtractor
        self.explorationProb = explorationProb
        self.weights = defaultdict(float)
        self.numIters = 0

    def getQ(self, state, action):
        """
         Return the Q function associated with the weights and features
        """
        score = 0
        for f, v in self.featureExtractor(state, action):
            score += self.weights[f] * v
        return score

    def getAction(self, state):
        """
        Produce an action given a state, using the epsilon-greedy algorithm: with probability
        |explorationProb|, take a random action.
        """
        self.numIters += 1
        if random.random() < self.explorationProb:
            return random.choice(self.actions(state))
        return max((self.getQ(state, action), action) for action in self.actions(state))[1]

    def getStepSize(self):
        """
        Return the step size to update the weights.
        """
        return 1.0 / math.sqrt(self.numIters)

    def incorporateFeedback(self, state, action, reward, newState):
        """
         We will call this function with (s, a, r, s'), which you should use to update |weights|.
         You should update the weights using self.getStepSize(); use
         self.getQ() to compute the current estimate of the parameters.

         HINT: Remember to check if s is a terminal state and s' None.
        """
        # BEGIN_YOUR_CODE

        if newState is not None:
            v_s = float('-inf')
            for act in self.actions(newState):
                v_s = max(self.getQ(newState, act), v_s)
        else:
            v_s = 0.0

        for f, v in self.featureExtractor(state, action):
            v_f = v
            self.weights[f] = self.weights[f] + self.getStepSize()*(reward + self.discount*v_s - self.getQ(state, action))*v_f


        # END_YOUR_CODE

def identityFeatureExtractor(state, action):
    """
    Return a single-element list containing a binary (indicator) feature
    for the existence of the (state, action) pair.  Provides no generalization.
    """
    featureKey = (state, action)
    featureValue = 1
    return [(featureKey, featureValue)]

# Large test case
largeMDP = BlackjackMDP(cardValues=[1, 3, 5, 8, 10], multiplicity=3, threshold=40, peekCost=1)

# **********************************************************
# **        PART 03-01 Features for Q-Learning             **
# **********************************************************

def blackjackFeatureExtractor(state, action):
    """
    You should return a list of (feature key, feature value) pairs.
    (See identityFeatureExtractor() above for a simple example.)
    """
    # BEGIN_YOUR_CODE
    featureKey = (state, action)
    featureValue = 1
    return [(featureKey, featureValue)]
    # END_YOUR_CODE
