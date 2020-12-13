require "minitest/autorun"
require_relative "../day8"

class Day8Tests < Minitest::Test
  def setup
    @instructions = [
      "nop +0",
      "acc +1",
      "jmp +4",
      "acc +3",
      "jmp -3",
      "acc -99",
      "acc +1",
      "jmp -4",
      "acc +6"
    ]
  end

  def test_day_8
    instructions = parse_instructions(@instructions)

    part1_result = execute_instructions(instructions)
    assert_equal 5, part1_result.acc

    part2_result = day8_part2(instructions, part1_result)
    assert_equal 8, part2_result.acc
  end
end
