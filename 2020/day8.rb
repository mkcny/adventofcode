# typed: strict
require 'sorbet-runtime'

extend T::Sig

class Instruction < T::Struct
  prop :command, String
  const :value, Integer
end

class Result < T::Struct
  const :acc, Integer
  const :run, T::Array[Integer]
end

sig { params(instructions: T::Array[Instruction]).returns(Result) }
def execute_instructions(instructions)
  acc = 0
  index = 0
  run = T.let([], T::Array[Integer])

  while instruction = instructions[index]
    break if run.include?(index)
    run << index

    case instruction.command
    when "nop"
      index = index + 1
    when "acc"
      index = index + 1
      acc = acc + instruction.value
    when "jmp"
      index = index + instruction.value
    end
  end

  puts "acc: #{acc}, run: #{run}"

  Result.new(acc: acc, run: run)
end

sig { params(lines: T::Array[String]).returns(T::Array[Instruction]) }
def parse_instructions(lines)
  lines.map { |line|
    cmd, value = T.must(line.match(/([a-z]{3}) ([0-9+\-]+)/)).captures
    Instruction.new(command: T.must(cmd), value: value.to_i)
  }
end


if __FILE__ == $0
  instructions = parse_instructions(File.read("input/day8").lines)
  result = execute_instructions(instructions)
  puts "part 1 result: #{result}"
end
