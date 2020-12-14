require "minitest/autorun"
require_relative "../day9"

class Day9Tests < Minitest::Test
  def test_sample
    input = [
      35,
      20,
      15,
      25,
      47,
      40,
      62,
      55,
      65,
      95,
      102,
      117,
      150,
      182,
      127,
      219,
      299,
      277,
      309,
      576
    ]
    preamble_size = 5

    part1_result = find_invalid_num(input, preamble_size)
    assert_equal 127, part1_result

    part2_result = day9_part2(input, part1_result)
    assert_equal 62, part2_result
  end
end
