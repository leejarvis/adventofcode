import itertools

class Intcode:
    def __init__(self, program):
        self.pos = 0
        self.program = program[:]
        self.inputs = []
        self.output = []
        self.running = False

    def inp(self, input):
        self.inputs.append(input)
        self.run()

    def run(self):
        self.running = True

        while True:
            op, p1, p2, p3 = self.program[self.pos:self.pos+4]

            p1mode = int(op / 100) % 10
            p2mode = int(op / 1000) % 10

            def el(en, i):
                if len(en) > i: return en[i]

            v1 = p1 if p1mode == 1 else el(self.program, p1)
            v2 = p2 if p2mode == 1 else el(self.program, p2)

            if op == 99:
                self.running = False
                return

            op = str(op)[-1]

            if op == "3" and len(self.inputs) == 0:
                return

            if op == "1":
                self.program[p3] = v1 + v2
                self.pos += 4
            elif op == "2":
                self.program[p3] = v1 * v2
                self.pos += 4
            elif op == "3":
                self.program[p1] = self.inputs.pop(0)
                self.pos += 2
            elif op == "4":
                self.output.append(v1)
                self.pos += 2
                break
            elif op == "5":
                if v1 == 0:
                    self.pos += 3
                else:
                    self.pos = v2
            elif op == "6":
                if v1 == 0:
                    self.pos = v2
                else:
                    self.pos += 3
            elif op == "7":
                self.program[p3] = 1 if v1 < v2 else 0
                self.pos += 4
            elif op == "8":
                self.program[p3] = 1 if v1 == v2 else 0
                self.pos += 4

def run(program, phases):
    computers = [Intcode(program) for _ in range(5)]
    for p, c in zip(phases, computers): c.inp(p)
    computers[0].inp(0)

    while computers[4].running is False:
        for i, c in computers:
            computers[(i+1) % 5].inp(c.output[-1])

    return computers[4].output[-1]

program = [int(x) for x in open("res/day7.txt").read().split(",")]

print(max(run(program, p) for p in itertools.permutations(range(5))))
print(max(run(program, p) for p in itertools.permutations(range(5, 10))))
