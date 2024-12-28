import gleam/dict
import gleeunit
import gleeunit/should
import util

pub fn main() {
  gleeunit.main()
}

pub fn tally_test() {
  util.tally([1, 2, 3, 3])
  |> should.equal(dict.from_list([#(1, 1), #(2, 1), #(3, 2)]))
}
