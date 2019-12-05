const instructions = require("fs")
    .readFileSync("res/day5.txt")
    .toString()
    .split(",")

function getModes(op) {
    const modes = op.split("").reverse().slice(2);
    return [modes[0] || "0", modes[1] || "0"];
}

function execute(instructions, input) {
    const ins = instructions.slice();
    var pos = 0;
    var out = "";

    while(1) {
        const [op, p1, p2, p3] = ins.slice(pos)
        const [p1mode, p2mode] = getModes(op);
        const v1 = p1mode == "1" ? +p1 : +ins[p1];
        const v2 = p2mode == "1" ? +p2 : +ins[p2];
        const v3 = +p3;

        if (op == "99") break;

        switch (+op.substr(-1)) {
        case 1:
            ins[v3] = (v1 + v2).toString();
            pos += 4;
            break;
        case 2:
            ins[v3] = (v1 * v2).toString();
            pos += 4;
            break;
        case 3:
            ins[+p1] = input;
            pos += 2;
            break;
        case 4:
            out = v1;
            pos += 2;
            break;
        case 5:
            (v1 == 0) ? pos += 3 : pos = v2;
            break;
        case 6:
            (v1 == 0) ? pos = v2 : pos += 3;
            break;
        case 7:
            ins[v3] = +(v1 < v2);
            pos += 4;
            break;
        case 8:
            ins[v3] = +(v1 == v2);
            pos += 4;
            break;
        }
    }

    return out;
}

console.log(execute(instructions, 1));
console.log(execute(instructions, 5));
