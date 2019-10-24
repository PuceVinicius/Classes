import random
import subprocess
import sys


class CodeBreaker(object):
    """ Represents the player trying to break the code """
    
    def __init__(self, nslots, ncolors):
        self.nslots = nslots
        self.ncolors = ncolors
        self.last_guess = None
        self.SAT = SATtradutor(nslots, ncolors)
        self._fixed_clauses()

    def _fixed_clauses(self):
        """ Fixed rules for the Mastermind game """
        self._rule_most_one_color()
        self._rule_least_one_color()

    def _rule_least_one_color(self):
        for i in range(self.nslots):
            clause = []
            for j in range(self.ncolors):
                clause.append(self.SAT.att_to_var(i, j))
            self.SAT.add_clause(clause)
    
    def _rule_most_one_color(self):
        for i in range(self.nslots):
            for j in range(self.ncolors - 1):
                for k in range(j + 1, self.ncolors):
                    aux1 = self.SAT.att_to_var(i, j)
                    aux2 = self.SAT.att_to_var(i, k)
                    clause = [-aux1, -aux2]
                    self.SAT.add_clause(clause)

    def guess(self):
        """ Uses a SAT solver to make a guess """
        self.last_guess = self.SAT.run_solver()
        return self.last_guess

    def convert_feedback(self, feedback):
        """
        This function should add clauses corresponding to the feedback
        obtained by the last guess. Returns True if won the game, 
        False otherwise.
        """
        count = 0 
        for i in range(self.nslots):
            if feedback[i]:
                count += 1
        if count == self.nslots:
            return True
      
        # Comment and uncomment these lines to test different strategies
        self._strategy_simple(feedback)    
        # self._strategy_full(feedback)    
        # self._strategy_new(feedback)    

        # Do not change the return statement 
        return False
    
    def _strategy_simple(self, feedback):
        n = self.nslots
        c = [-self.SAT.att_to_var(i, self.last_guess[i]) for i in range(n)]
        self.SAT.add_clause(c)

    def _strategy_full(self, feedback):
        for i in range(self.nslots):
            color = self.last_guess[i]
            if feedback[i] == True:
                self.SAT.add_clause([self.SAT.att_to_var(i, color)])
            else:
                self.SAT.add_clause([-self.SAT.att_to_var(i, color)])

    # Create this one strategy
    def _strategy_new(self, feedback):
        pass


class CodeMaker(object):
    """ Represents the player that created the code """

    def __init__(self, nslots, ncolors):
        self.nslots = nslots
        self.ncolors = ncolors
        self._create_code()

    def _create_code(self):
        self.code = random.choices(range(self.ncolors), k=self.nslots)

    def feedback(self, guess):
        """
        A feedback is a list, indicating for each position it has: True if 
        the guess at that position was right, False otherwise.
        """
        feedback = [self.code[i] == guess[i] for i in range(len(guess))]
        return feedback

class Mastermind(object):
    """ Represents the game itself """

    def __init__(self, nslots, ncolors, tries):
        self.tries = tries
        self.codemaker = CodeMaker(nslots, ncolors)
        self.codebreaker = CodeBreaker(nslots, ncolors)
        print("Code: {}".format(self.codemaker.code))

    def play(self):
        """ 
        Runs the game for the specified number of tries.
        Returns True if the CodeBreaker guessed the code within the given tries,
        otherwise returns False
        """
        for i in range(self.tries):
            guess = self.codebreaker.guess()
            print("Guess {}: {}".format(i + 1, guess))
            feedback = self.codemaker.feedback(guess)
            if self.codebreaker.convert_feedback(feedback):
                return True
            self.tries -= 1
        return False

class SATtradutor(object):
    """ Encapsulates the SAT solver """

    def __init__(self, nslots, ncolors):
        self.nslots = nslots
        self.ncolors = ncolors
        self.fname = "mastermindsat.txt"
        self.satfile = open(self.fname, "w")
        self.nclauses = 0
        self._write_header()
        if not self.satfile:
            raise Exception("Error creating file")

    def _write_header(self):
        """ Writes the header of the SAT file"""
        self.satfile.seek(0, 0) # go to the beggining
        self.satfile.write("c\n")
        self.satfile.write("c Mastermind - SAT\n")
        self.satfile.write("c\n")
        nvars = self.nslots * self.ncolors
        self.satfile.write("p cnf {} {}\n".format(nvars, self.nclauses))
        self.satfile.close()

    def _rewrite(self):
        """ Fixes the header of the SAT file"""
        self.satfile = open(self.fname, "r")
        self.satfile.seek(0, 0) # go to the beggining
        data = self.satfile.readlines()
        self.satfile = open(self.fname, "w")
        nvars = self.nslots * self.ncolors
        data[3] = "p cnf {} {}\n".format(nvars, self.nclauses)
        self.satfile.writelines(data)
        self.satfile.close()

    def add_clause(self, clause):
        """ Adds a single clause to the SAT file """
        self.satfile = open(self.fname, "a+")
        self.satfile.seek(0, 2) # go to the end of file
        self.nclauses += 1
        clause.append(0)
        line = " ".join(str(x) for x in clause)
        self.satfile.write(line)
        self.satfile.write('\n')
        self.satfile.close()

    def add_clauses(self, clauses):
        """ Adds a list of clauses to the SAT file """
        for clause in clauses:
            self.add_clause(clause)

    def run_solver(self):
        """ Runs the SAT solver with the SAT file """
        self._rewrite()
        cmd = ["./lingeling", "-q", self.fname]
        answer = ''
        try:
            answer = subprocess.check_output(cmd)
        except subprocess.CalledProcessError as e:
            # For some reason the return code is always non-zero
            # thus we must get the real output value here
            answer = e.output.decode('utf-8')
        return self._parse_answer(answer)

    def _parse_answer(self, answer):
        """ 
        Converts the SAT output to a list, where each position has the
        color of the corresponding slot. Returns None, if no solution could
        be found
        """
        guess = {} 
        data = answer.split()
        if data[1] != "SATISFIABLE":
            return None
        for token in data[2:]:
            if token == 'v':
                pass
            else:
                value = int(token)
                if value > 0:
                    slot, color = self.var_to_att(value)
                    guess[slot] = color
        return [guess[i] for i in range(self.nslots)]

    def att_to_var(self, slot, color):
        """ Converts the attribution of a color to a slot into a code which
            represents a literal/propositional variable """
        return color*self.nslots + slot + 1

    def var_to_att(self, value):
        """
        Converts a value in the SAT file to the corresponding attribution of
        color to a slot
        """
        value = value - 1
        return (value % self.nslots, value // self.nslots)
    
if __name__ ==  '__main__':
    nslots = int(sys.argv[1])
    ncolors = int(sys.argv[2])
    ntries = int(sys.argv[3])
    game = Mastermind(nslots, ncolors, ntries)
    if game.play():
        winner = "CodeBreaker"
    else:
        winner = "CodeMaker"
    print("{} wins!".format(winner))
