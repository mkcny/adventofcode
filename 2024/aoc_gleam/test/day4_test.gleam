import day4
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn part1_test() {
  day4.step1() |> should.equal(Ok(2496))
}
