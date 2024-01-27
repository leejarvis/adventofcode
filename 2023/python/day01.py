import fileinput

input = [line.strip() for line in fileinput.input()]
p1 = 0

for line in input:
    digits = []
    for i, char in enumerate(line):
        if char.isdigit():
            digits.append(char)
    p1 += int(digits[0] + digits[-1])

print(p1)
