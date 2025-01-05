import day9
import gleam/io
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  use input <- result.map(simplifile.read("input/day9"))
  day9.step1(string.trim(input)) |> io.debug
}
