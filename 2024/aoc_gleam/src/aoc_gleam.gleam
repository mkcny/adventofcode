import day6
import gleam/io
import gleam/result
import simplifile

pub fn main() {
  use input <- result.map(simplifile.read("input/day6"))
  day6.step2(input) |> io.debug
}
