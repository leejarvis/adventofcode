// gcc day02.c && ./a.out && rm a.out

#include <stdio.h>

#define LEN 149
int program[LEN];

void read_input() {
    FILE *fh = fopen("res/day2.txt", "r");
    for (int i = 0; i < LEN; i++) {
        fscanf(fh, "%d%*c", &program[i]);
    }
    fclose(fh);
}

void execute(int *program) {
    int pos = 0;
    int op = program[pos];

    while (op != 99) {
        int a1 = program[pos + 1];
        int v1 = program[a1];

        int a2 = program[pos + 2];
        int v2 = program[a2];

        int loc = program[pos + 3];

        if (op == 1) {
            program[loc] = v1 + v2;
        } else if (op == 2) {
            program[loc] = v1 * v2;
        }

        pos += 4;
        op = program[pos];
    }
}

void part1() {
    program[1] = 12;
    program[2] = 2;

    execute(program);

    printf("%d\n", program[0]);
}

void part2() {
    read_input();

    for (int noun = 0; noun < 1000; noun++) {
        for (int verb = 0; verb < 1000; verb++) {
            read_input();

            program[1] = noun;
            program[2] = verb;

            execute(program);

            if (program[0] == 19690720) {
                printf("%d%d\n", noun, verb);
                return;
            }
        }
    }
}

int main() {
    read_input();
    part1();

    part2();

    return 0;
}
