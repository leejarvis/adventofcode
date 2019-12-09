import itertools

# Pretty much just copied the JS code from day5.. ¯\_(ツ)_/¯

def execute(instructions, inputs):
    pos = 0

    while True:
        op, p1, p2, p3 = instructions[pos:pos+4]

        p1mode = int(op / 100) % 10
        p2mode = int(op / 1000) % 10

        def el(en, i):
            if len(en) > i: return en[i]

        v1 = p1 if p1mode == 1 else el(instructions, p1)
        v2 = p2 if p2mode == 1 else el(instructions, p2)

        if op == 99: break

        op = str(op)[-1]

        if op == "1":
            instructions[p3] = v1 + v2
            pos += 4
        elif op == "2":
            instructions[p3] = v1 * v2
            pos += 4
        elif op == "3":
            instructions[p1] = inputs.pop(0)
            pos += 2
        elif op == "4":
            value = v1
            pos += 2
            break
        elif op == "5":
            if v1 == 0:
                pos += 3
            else:
                pos = v2
        elif op == "6":
            if v1 == 0:
                pos = v2
            else:
                pos += 3
        elif op == "7":
            instructions[p3] = 1 if v1 < v2 else 0
            pos += 4
        elif op == "8":
            instructions[p3] = 1 if v1 == v2 else 0
            pos += 4

    return value

instructions = [int(x) for x in open("res/day7.txt").read().split(",")]
max_signal = 0

for phases in itertools.permutations([0, 1, 2, 3, 4]):
    signal = 0

    for phase in phases:
        signal = execute(instructions, [phase, signal])

    max_signal = max(max_signal, signal)

print(max_signal)
