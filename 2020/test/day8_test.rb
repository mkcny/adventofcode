require "minitest/autorun"
require_relative "../day8"

class Day8Tests < Minitest::Test
  def test_example_input
    instructions = [
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
    result = execute_instructions(parse_instructions(instructions))
    assert_equal 5, result.acc
  end

  def test_example_input_part_2
    instructions = [
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
    instructions = parse_instructions(instructions)
    instructions[7].command = "nop"
    result = execute_instructions(instructions)
    assert_equal 8, result.acc
  end

end
