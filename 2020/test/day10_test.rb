# typed: false
require "minitest/autorun"
require_relative "../day10"

class Day10Tests < Minitest::Test
  def test_part1
    input = [
      16,
      10,
      15,
      5,
      1,
      11,
      7,
      19,
      6,
      12,
      4
    ]
    result = day10_part1(input.sort)
    assert_equal 35, result
  end
end
