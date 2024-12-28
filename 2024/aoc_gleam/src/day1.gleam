import gleam/dict
import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn step1() {
  use input <- result.map(simplifile.read("input/day1"))

  let cols =
    input
    |> string.split("\n")
    |> list.map(string.split(_, "   "))
    |> list.transpose
    |> list.map(list.sort(_, by: string.compare))
    |> list.map(list.filter_map(_, int.parse(_)))

  let assert [col1, col2] = cols

  let sum =
    list.map2(col1, col2, int.subtract)
    |> list.map(int.absolute_value)
    |> list.fold(0, int.add)

  io.debug(sum)
}

pub fn step2() {
  use input <- result.map(simplifile.read("input/day1"))

  let cols =
    input
    |> string.split("\n")
    |> list.map(string.split(_, "   "))
    |> list.transpose
    |> list.map(list.sort(_, by: string.compare))
    |> list.map(list.filter_map(_, int.parse(_)))

  let assert [col1, col2] = cols

  let counts =
    col2
    |> list.group(function.identity)
    |> dict.map_values(fn(_, value) { list.length(value) })

  let similarity_score =
    col1
    |> list.filter_map(fn(x) {
      dict.get(counts, x) |> result.map(int.multiply(_, x))
    })
    |> list.fold(0, int.add)

  io.debug(similarity_score)
}
