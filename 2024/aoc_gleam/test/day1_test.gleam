import day1
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn part1_test() {
  day1.step1() |> should.equal(Ok(2_086_478))
}

pub fn part2_test() {
  day1.step2() |> should.equal(Ok(24_941_624))
}
