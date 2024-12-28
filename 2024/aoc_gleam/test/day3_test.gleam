import day3
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn part1_test() {
  day3.step1() |> should.equal(Ok(173_517_243))
}

pub fn part2_test() {
  day3.step2() |> should.equal(Ok(100_450_138))
}
