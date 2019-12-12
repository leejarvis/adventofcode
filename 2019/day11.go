package main

import (
	"fmt"
	"io/ioutil"
	"math"
	"strconv"
	"strings"
)

type Point struct{ x, y int }

func (p Point) add(other Point) Point {
	return Point{p.x + other.x, p.y + other.y}
}

func readInstructions() map[int]int {
	instructions := map[int]int{}
	contents, _ := ioutil.ReadFile("res/day11.txt")

	for index, char := range strings.Split(string(contents), ",") {
		c, _ := strconv.ParseInt(char, 10, 0)
		instructions[index] = int(c)
	}

	return instructions
}

func display(panels map[Point]int) {
	output := ""

	minX, maxX := 0.0, 0.0
	minY, maxY := 0.0, 0.0

	for point, _ := range panels {
		minX = math.Min(minX, float64(point.x))
		maxX = math.Max(maxX, float64(point.x))
		minY = math.Min(minY, float64(point.y))
		maxY = math.Max(maxY, float64(point.y))
	}

	for y := maxY; y >= minY; y-- {
		fmt.Println()

		for x := minX; x < maxX; x++ {
			if panels[Point{int(x), int(y)}] != 0 {
				fmt.Print("X")
			} else {
				fmt.Print(" ")
			}
		}
	}

	fmt.Print(output)
}

func main() {
	instructions := readInstructions()
	input, output := make(chan int, 1), make(chan int)
	panels := map[Point]int{}
	point := Point{0, 0}
	direction := 0
	moves := []Point{Point{0, -1}, Point{-1, 0}, Point{0, 1}, Point{1, 0}}

	go execute(instructions, input, output)
	input <- 0

	for panels[point] = range output {
		direction = (direction + 2*int(<-output) + 1) % 4
		point = point.add(moves[direction])
		input <- panels[point]
	}

	fmt.Println(len(panels))

	display(panels)
}

// See day09.pl
func execute(mem map[int]int, input <-chan int, output chan<- int) {
	shifts := []int{0, 4, 4, 2, 2, 3, 3, 4, 4, 2}
	pos, rel := 0, 0

	for {
		op := mem[pos]

		if op == 99 {
			close(output)
			return
		}

		param := func(offset int) int {
			return []int{
				mem[pos+offset],
				pos + offset,
				mem[pos+offset] + rel,
			}[int(float64(op)/math.Pow(10, float64(offset+1)))%10]
		}

		p1, p2, p3 := param(1), param(2), param(3)
		op = op % 100

		pos += shifts[op]

		switch op {
		case 1: mem[p3] = mem[p1] + mem[p2]
		case 2: mem[p3] = mem[p1] * mem[p2]
		case 3: mem[p1] = <-input
		case 4: output <- mem[p1]
		case 5: if mem[p1] != 0 { pos = mem[p2] }
		case 6: if mem[p1] == 0 { pos = mem[p2] }
		case 7: if mem[p1] < mem[p2] { mem[p3] = 1 } else { mem[p3] = 0 }
		case 8: if mem[p1] == mem[p2] { mem[p3] = 1 } else { mem[p3] = 0 }
		case 9: rel += int(mem[p1])
		}
	}
}
