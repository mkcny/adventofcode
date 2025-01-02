import day7
import gleam/io
import gleam/result
import simplifile

pub fn main() {
  use input <- result.map(simplifile.read("input/day7"))
  day7.step2(input) |> io.debug
}
