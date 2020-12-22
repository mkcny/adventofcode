# typed: false
require "minitest/autorun"
require_relative "../day10"

class Day10Tests < Minitest::Test
  def setup
    @input = [
      0,  # 0
      1,  # 1
      4,  # 2
      5,  # 3
      6,  # 4
      7,  # 5
      10, # 6
      11, # 7
      12, # 8
      15, # 9
      16, # 10
      19, # 11
      22  # 12
    ]
  end

  def test_part1
    result = day10_part1(@input)
    assert_equal 35, result
  end

  def test_part2
    assert_equal 1, count_all_paths(@input, 7)
    assert_equal 8, count_all_paths(@input)
  end
end
