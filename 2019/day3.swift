let input = "..."

func points(_ wire: String) -> [[Int]] {
    var points = [[0, 0]]

    wire.split(separator: ",").forEach { ins in
        let dir = ins.prefix(1)
        let n = Int(ins[dir.index(dir.startIndex, offsetBy:1)...])!

        for _ in 0..<n {
            var point = points.last!

            switch dir {
            case "U": point[1] += 1
            case "R": point[0] += 1
            case "D": point[1] -= 1
            case "L": point[0] -= 1
            default: print("nada")
            }

            points.append(point)
        }
    }

    return points
}

let wires = input.split(separator: "\n")
let p1 = Set(points(String(wires[0])))
let p2 = Set(points(String(wires[1])))
let intersections = p1.intersection(p2).map { abs($0[0]) + abs($0[1]) }

debugPrint(intersections.sorted()[1])
