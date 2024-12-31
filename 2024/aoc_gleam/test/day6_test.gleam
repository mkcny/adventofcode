import day6
import gleam/result
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

const sample_input = "....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."

pub fn part1_sample_test() {
  day6.step1(sample_input) |> should.equal(41)
}

pub fn part1_test() {
  use input <- result.map(simplifile.read("input/day6"))
  day6.step1(input) |> should.equal(4883)
}

pub fn part2_sample_test() {
  day6.step2(sample_input) |> should.equal(6)
}
