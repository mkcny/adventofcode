import day5
import gleam/result
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

pub fn part1_sample_test() {
  let input =
    "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47"

  day5.step1(input) |> should.equal(143)
}

pub fn part1_test() {
  use input <- result.map(simplifile.read("input/day5"))
  day5.step1(input) |> should.equal(5948)
}

pub fn get_middle_number_test() {
  day5.get_middle_number([75, 47, 61, 53, 29]) |> should.equal(61)
}

pub fn rule_applies_test() {
  day5.rule_applies([75, 47, 61, 53, 29], [47, 53]) |> should.be_true()
  day5.rule_applies([75, 47, 61, 53, 29], [97, 13]) |> should.be_false()
  day5.rule_applies([75, 47, 61, 53, 29], [47, 13]) |> should.be_false()
}

pub fn rule_followed_test() {
  day5.rule_followed([75, 47, 61, 53, 29], [47, 53]) |> should.be_true()
  day5.rule_followed([75, 97, 47, 61, 53], [97, 75]) |> should.be_false()
}
