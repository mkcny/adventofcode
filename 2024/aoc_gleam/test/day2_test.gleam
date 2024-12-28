import day2
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn part1_test() {
  day2.step1() |> should.equal(Ok(299))
}

pub fn part2_test() {
  day2.step2() |> should.equal(Ok(364))
}
