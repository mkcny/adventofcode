import day9
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const sample_input = "2333133121414131402"

pub fn part1_sample_test() {
  day9.step1(sample_input) |> should.equal(1928)
}
