import gleam/dict
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import simplifile
import util

fn get_cols() {
  use input <- result.map(simplifile.read("input/day1"))

  let assert [col1, col2] =
    input
    |> string.split("\n")
    |> list.map(string.split(_, "   "))
    |> list.transpose
    |> list.map(list.sort(_, by: string.compare))
    |> list.map(list.filter_map(_, int.parse(_)))

  #(col1, col2)
}

pub fn step1() {
  use #(col1, col2) <- result.map(get_cols())

  list.map2(col1, col2, int.subtract)
  |> list.map(int.absolute_value)
  |> list.fold(0, int.add)
}

pub fn step2() {
  use #(col1, col2) <- result.map(get_cols())

  let counts = util.tally(col2)

  col1
  |> list.filter_map(fn(x) {
    dict.get(counts, x) |> result.map(int.multiply(_, x))
  })
  |> list.fold(0, int.add)
}
