import gleam/int
import gleam/list
import gleam/option
import gleam/regexp
import gleam/result
import simplifile

pub fn step1() {
  use input <- result.map(simplifile.read("input/day3"))

  let assert Ok(re) = regexp.from_string("mul\\(([0-9]{1,3}),([0-9]{1,3})\\)")

  regexp.scan(re, input)
  |> list.map(fn(match) {
    let assert [a, b] =
      match.submatches
      |> list.map(fn(x) {
        option.unwrap(x, "0") |> int.parse() |> result.unwrap(0)
      })
    a * b
  })
  |> list.fold(0, int.add)
}
