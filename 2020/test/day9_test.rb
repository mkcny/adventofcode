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
    result = find_invalid_num(input, preamble_size)
    assert_equal 127, result
  end
end
