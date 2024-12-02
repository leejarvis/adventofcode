import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

fn part1() {
  let #(left, right) = split()
  total_distance(left, right, 0)
}

fn part2() {
  let #(left, right) = split()
  similarity_score(left, right, 0)
}

fn total_distance(left, right, total) {
  case left, right {
    [], [] -> total
    [l, ..rl], [r, ..rr] ->
      total_distance(rl, rr, total + int.absolute_value(l - r))
    _, _ -> 0
  }
}

fn similarity_score(left, right, total) {
  case left {
    [] -> total
    [l, ..rl] ->
      similarity_score(
        rl,
        right,
        total + l * list.count(right, fn(x) { x == l }),
      )
  }
}

fn split() {
  let assert Ok(input) = simplifile.read("priv/day01.txt")
  string.split(input, "\n")
  |> list.fold(#([], []), fn(acc, line) {
    let cols =
      line
      |> string.split("   ")
      |> list.try_map(int.parse)

    case cols {
      Ok([c1, c2]) -> #(
        list.sort([c1, ..acc.0], int.compare),
        list.sort([c2, ..acc.1], int.compare),
      )
      _ -> acc
    }
  })
}

pub fn run() {
  io.debug(#(part1(), part2()))
}
