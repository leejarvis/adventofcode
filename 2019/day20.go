package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

type v3 struct {
	x, y, z int
}

func vec(xyz ...int) (v v3) {
	v.x = xyz[0]
	v.y = xyz[1]
	if len(xyz) > 2 {
		v.z = xyz[2]
	}
	return
}

type bfs struct {
	pos   v3
	steps int
}

type portal struct {
	name  string
	pos   v3
	dest  v3
	outer bool
}

type maze struct {
	m       map[v3]bool
	portals map[v3]portal
	start   v3
	finish  v3
}

func (m *maze) plot(v v3) {
	m.m[v] = true
}

func (m *maze) at(v v3) bool {
	return m.m[v]
}

func (m *maze) addPortal(name string, ppos v3, x, y int, outer bool) {
	pos := vec(x, y)

	if name == "AA" {
		m.start = pos
	} else if name == "ZZ" {
		m.finish = pos
	} else {
		m.portals[pos] = portal{name: name, pos: ppos, outer: outer}
		m.plot(pos)
	}
}

func (m *maze) createLinks() {
	for i, p1 := range m.portals {
		for _, p2 := range m.portals {
			if p1.name == p2.name && p1.pos != p2.pos {
				p1.dest = p2.pos
				m.portals[i] = p1
			}
		}
	}
}

func getInput() (x []string) {
	contents, _ := ioutil.ReadFile("res/day20.txt")
	for _, line := range strings.Split(string(contents), "\n") {
		x = append(x, line)
	}
	return
}

func getParsePositions(lines []string) (o1 v3, o2 v3, i1 v3, i2 v3) {
	o1, o2 = vec(2, 2), vec(len(lines[0])-3, len(lines)-3)

	for y := o1.y; ; y++ {
		line := lines[y][o1.x:o2.x]

		if strings.Contains(line, " ") {
			i1 = vec(strings.Index(line, " ")+o1.x-1, y-1)
			i2 = vec(o2.x-i1.x+o1.x, o2.y-i1.y+o1.y)
			return
		}
	}
}

func parseMaze() maze {
	m := maze{m: map[v3]bool{}, portals: map[v3]portal{}}
	lines := getInput()
	o1, o2, i1, i2 := getParsePositions(lines)

	for y := o1.y; y <= o2.y; y++ {
		for x := o1.x; x <= o2.x; x++ {
			if lines[y][x] != '.' {
				continue
			}

			pos := vec(x, y)
			m.plot(pos)

			if y == o1.y {
				m.addPortal(lines[y-2][x:x+1]+lines[y-1][x:x+1], pos, x, y-1, true)
			} else if y == o2.y {
				m.addPortal(lines[y+1][x:x+1]+lines[y+2][x:x+1], pos, x, y+1, true)
			} else if x == o1.x {
				m.addPortal(lines[y][x-2:x], pos, x-1, y, true)
			} else if x == o2.x {
				m.addPortal(lines[y][x+1:x+3], pos, x+1, y, true)
			} else if y == i2.y && x > i1.x && x < i2.x {
				m.addPortal(lines[y-2][x:x+1]+lines[y-1][x:x+1], pos, x, y-1, false)
			} else if y == i1.y && x > i1.x && x < i2.x {
				m.addPortal(lines[y+1][x:x+1]+lines[y+2][x:x+1], pos, x, y+1, false)
			} else if x == i2.x && y > i1.y && y < i2.y {
				m.addPortal(lines[y][x-2:x], pos, x-1, y, false)
			} else if x == i1.x && y > i1.y && y < i2.y {
				m.addPortal(lines[y][x+1:x+3], pos, x+1, y, false)
			}
		}
	}

	m.createLinks()

	return m
}

func solve(m maze, recursive bool) {
	delta := []v3{{0, -1, 0}, {1, 0, 0}, {0, 1, 0}, {-1, 0, 0}}
	q := []bfs{bfs{pos: m.start}}
	v := map[v3]bool{m.start: true}

	for {
		curr := q[0]
		q = q[1:]

		for _, d := range delta {
			pos := vec(curr.pos.x+d.x, curr.pos.y+d.y, curr.pos.z)

			if pos == m.finish {
				fmt.Println(curr.steps - 1)
				return
			}

			if v[pos] {
				continue
			}
			v[pos] = true

			if recursive && m.at(vec(pos.x, pos.y)) {
				p, ok := m.portals[vec(pos.x, pos.y)]
				if ok && (curr.pos.z >= 0 || !p.outer) {
					pos = vec(p.dest.x, p.dest.y, curr.pos.z)

					if p.outer {
						pos.z--
					} else {
						pos.z++
					}

					v[pos] = true
				}

				q = append(q, bfs{pos, curr.steps + 1})
			} else if m.at(pos) {
				p, ok := m.portals[pos]
				if ok {
					pos = p.dest
				}

				q = append(q, bfs{pos, curr.steps + 1})
			}
		}
	}
}

func main() {
	maze := parseMaze()

	solve(maze, false)
	solve(maze, true)
}
