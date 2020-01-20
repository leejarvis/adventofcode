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

void copy_program(int *into) {
    for (int i = 0; i < LEN; i++) {
        into[i] = program[i];
    }
}

void execute(int *prog) {
    int pos = 0;
    int op = prog[pos];

    while (op != 99) {
        int a1 = prog[pos + 1];
        int v1 = prog[a1];

        int a2 = prog[pos + 2];
        int v2 = prog[a2];

        int loc = prog[pos + 3];

        if (op == 1) {
            prog[loc] = v1 + v2;
        } else if (op == 2) {
            prog[loc] = v1 * v2;
        }

        pos += 4;
        op = prog[pos];
    }
}

void part1() {
    int *prog;
    copy_program(prog);

    prog[1] = 12;
    prog[2] = 2;

    execute(prog);

    printf("%d\n", prog[0]);
}

void part2() {
    int *prog;

    copy_program(prog);

    for (int noun = 0; noun < 1000; noun++) {
        for (int verb = 0; verb < 1000; verb++) {
            copy_program(prog);

            prog[1] = noun;
            prog[2] = verb;

            execute(prog);

            if (prog[0] == 19690720) {
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
