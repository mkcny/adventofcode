import day9
import gleam/deque
import gleam/string
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const sample_input = "2333133121414131402"

pub fn part1_sample_test() {
  day9.step1(sample_input) |> should.equal(1928)
}

pub fn get_blocks_test() {
  let expected_list =
    string.to_graphemes("00...111...2...333.44.5555.6666.777.888899")
  day9.get_blocks(sample_input) |> deque.to_list |> should.equal(expected_list)

  day9.get_blocks("12345")
  |> deque.to_list
  |> should.equal(string.to_graphemes("0..111....22222"))
}

pub fn compact_test() {
  let blocks = deque.from_list(string.to_graphemes("0..111....22222"))
  day9.compact(blocks, "") |> should.equal("022111222")

  let blocks =
    deque.from_list(string.to_graphemes(
      "00...111...2...333.44.5555.6666.777.888899",
    ))
  day9.compact(blocks, "") |> should.equal("0099811188827773336446555566")
}

pub fn checksum_test() {
  day9.checksum("0099811188827773336446555566") |> should.equal(1928)
}

pub fn get_from_end_test() {
  let blocks = deque.from_list(["1", ".", "."])
  let assert Ok(#(char, queue)) = day9.get_from_end(blocks)
  char |> should.equal("1")
  deque.is_empty(queue) |> should.be_true

  let blocks = deque.from_list([".", "1"])
  let assert Ok(#(char, queue)) = day9.get_from_end(blocks)
  char |> should.equal("1")
  deque.is_empty(queue) |> should.be_false

  let blocks = deque.new()
  let assert Error(Nil) = day9.get_from_end(blocks)
}
