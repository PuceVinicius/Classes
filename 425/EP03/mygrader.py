import util
from ep3 import *
smallMDP = BlackjackMDP(cardValues=[1, 5], multiplicity=2,
                                   threshold=15, peekCost=1)
preEmptyState = (11, None, (1,0))
# Make sure the succAndProbReward function is implemented correctly.
total_tests = 0
test_results = 0
tests = [
    ([((12, None, None), 1.0, 12)], smallMDP, preEmptyState, 'Take'),
    ([((5, None, (2, 1)), 1, 0)], smallMDP, (0, 1, (2, 2)), 'Take')
]
for gold, mdp, state, action in tests:
    total_tests += 1
    if  gold==mdp.succAndProbReward(state, action):
        test_results += 1
alg = ValueIteration()
alg.solve(smallMDP)
counter = 0
counter2 = 0
for _, val in alg.pi.items():
    print(val)
    counter2 +=1
    if val=="Take":
        counter += 1
print(counter)
print(counter2)
part_tests = 0
part_correct = 0
part_correct += test_results
part_tests += total_tests
test_results = 0
total_tests = 0
if part_tests > 0:
    final_grades=(10.0*part_correct)/part_tests
print(final_grades)
