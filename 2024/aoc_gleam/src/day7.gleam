import gleam/bool
import gleam/int
import gleam/list
import gleam/option
import gleam/result
import gleam/set
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

pub fn combinations_of_length(pair: #(a, a), length: Int) -> set.Set(List(a)) {
  list.range(0, length)
  |> list.map(fn(num) {
    list.append(list.repeat(pair.0, num), list.repeat(pair.1, length - num))
  })
  |> list.flat_map(list.permutations)
  |> set.from_list
}

type Operations {
  Add
  Multiply
}

fn can_be_solved(equation: #(Int, List(Int))) -> Bool {
  let #(total, ints) = equation

  combinations_of_length(#(Add, Multiply), list.length(ints))
  |> set.to_list
  |> list.find(fn(operations) {
    apply_operators_to_list(ints, operations, option.None) |> option.unwrap(0)
    == total
  })
  |> result.is_ok
}

fn apply_operators_to_list(
  ints: List(Int),
  operations: List(Operations),
  acc: option.Option(Int),
) -> option.Option(Int) {
  use <- bool.guard(when: list.is_empty(ints), return: acc)

  let assert [num, ..remaining_nums] = ints
  let assert [op, ..remaining_ops] = operations

  let acc = case op {
    Add -> option.unwrap(acc, 0) + num
    Multiply -> option.unwrap(acc, 1) * num
  }

  apply_operators_to_list(remaining_nums, remaining_ops, option.Some(acc))
}

pub fn step1(input) {
  parse_input(input)
  |> list.filter(can_be_solved)
  |> list.map(fn(x) { x.0 })
  |> list.fold(0, int.add)
}
