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
    result = execute_instructions(instructions)
    assert_equal 5, result
  end

end
