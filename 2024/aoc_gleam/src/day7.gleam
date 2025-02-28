import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn parse_input(input: String) -> List(#(Int, List(Int))) {
  string.split(input, "\n")
  |> list.map(fn(line) {
    let assert [result, int_string] = string.split(line, ": ")

    let ints =
      int_string
      |> string.split(" ")
      |> list.filter_map(int.parse)

    let result = result |> int.parse |> result.unwrap(0)

    #(result, ints)
  })
}

fn can_be_solved(equation: #(Int, List(Int)), operations) -> Bool {
  let #(solution, ints) = equation
  let assert [first, ..rest] = ints
  solve(solution, rest, first, operations)
}

fn concat(a: Int, b: Int) -> Int {
  int.parse(int.to_string(a) <> int.to_string(b)) |> result.unwrap(0)
}

fn solve(solution: Int, ints: List(Int), tally: Int, operations) -> Bool {
  case ints {
    [] -> solution == tally
    [first, ..rest] -> {
      list.any(operations, fn(op) {
        solve(solution, rest, op(tally, first), operations)
      })
    }
  }
}

pub fn step1(input) {
  parse_input(input)
  |> list.filter(can_be_solved(_, [int.add, int.multiply]))
  |> list.map(fn(x) { x.0 })
  |> list.fold(0, int.add)
}

pub fn step2(input) {
  parse_input(input)
  |> list.filter(can_be_solved(_, [int.add, int.multiply, concat]))
  |> list.map(fn(x) { x.0 })
  |> list.fold(0, int.add)
}
