import day7
import gleam/result
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

const sample_input = "190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20"

pub fn part1_sample_test() {
  day7.step1(sample_input) |> should.equal(3749)
}

pub fn part1_test() {
  use input <- result.map(simplifile.read("input/day7"))
  day7.step1(input) |> should.equal(3_598_800_864_292)
}

pub fn part2_sample_test() {
  day7.step2(sample_input) |> should.equal(11_387)
}

pub fn part2_test() {
  use input <- result.map(simplifile.read("input/day7"))
  day7.step2(input) |> should.equal(340_362_529_351_427)
}
