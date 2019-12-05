// gcc day2.c && ./a.out && rm a.out

#include <stdio.h>

#define LEN 149
int instructions[LEN];

void read_input() {
    FILE *fh = fopen("res/day2.txt", "r");
    for (int i = 0; i < LEN; i++) {
        fscanf(fh, "%d%*c", &instructions[i]);
    }
    fclose(fh);
}

int main() {
    read_input();

    instructions[1] = 12;
    instructions[2] = 2;

    int pos = 0;
    int op = instructions[pos];

    while (op != 99) {
        int a1 = instructions[pos + 1];
        int v1 = instructions[a1];

        int a2 = instructions[pos + 2];
        int v2 = instructions[a2];

        int loc = instructions[pos + 3];

        if (op == 1) {
            instructions[loc] = v1 + v2;
        } else if (op == 2) {
            instructions[loc] = v1 * v2;
        }

        pos += 4;
        op = instructions[pos];
    }

    printf("%d\n", instructions[0]);

    return 0;
}
