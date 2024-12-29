import day4
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn part1_test() {
  day4.step1() |> should.equal(Ok(2496))
}

pub fn part2_test() {
  day4.step2() |> should.equal(Ok(1967))
}
