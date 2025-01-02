import day8
import gleam/result
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

const sample_input = "............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............"

pub fn part1_sample_test() {
  day8.step1(sample_input) |> should.equal(14)
}

pub fn part1_test() {
  use input <- result.map(simplifile.read("input/day8"))
  day8.step1(input) |> should.equal(354)
}
