# typed: strict
require 'sorbet-runtime'

extend T::Sig

sig { params(instructions: T::Array[String]).returns(Integer) }
def execute_instructions(instructions)
  acc = 0
  index = 0
  run = T.let([], T::Array[Integer])

  while instruction = instructions[index]
    cmd, value = T.must(instruction.match(/([a-z]{3}) ([0-9+\-]+)/)).captures
    break if run.include?(index)
    run << index

    #binding.pry
    #puts instruction

    case cmd
    when "nop"
      index = index + 1
    when "acc"
      index = index + 1
      acc = acc + value.to_i
    when "jmp"
      index = index + value.to_i
    end
  end

  acc
end


if __FILE__ == $0
  instructions = File.read("input/day8").lines
  result = execute_instructions(instructions)
  puts "part 1 result: #{result}"
end
