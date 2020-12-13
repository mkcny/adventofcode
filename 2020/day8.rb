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

  Result.new(acc: acc, run: run)
end

sig { params(lines: T::Array[String]).returns(T::Array[Instruction]) }
def parse_instructions(lines)
  lines.map { |line|
    cmd, value = T.must(line.match(/([a-z]{3}) ([0-9+\-]+)/)).captures
    Instruction.new(command: T.must(cmd), value: value.to_i)
  }
end

sig { params(instructions: T::Array[Instruction], index: Integer, block: T.proc.void).void }
def flip_instruction(instructions, index, &block)
  inst = instructions.fetch(index)
  orig = inst.command
  inst.command = orig == "jmp" ? "nop" : "jmp"

  yield

  inst.command = orig
end

sig { params(instructions: T::Array[Instruction], part1_result: Result).returns(Result) }
def day8_part2(instructions, part1_result)
  indexes_to_try = part1_result.run
    .filter { ["jmp", "nop"].include?(instructions.fetch(_1).command) }

  indexes_to_try.each do |index|
    flip_instruction(instructions, index) do
      result = execute_instructions(instructions)
      return result if result.run.include?(instructions.each_index.max)
    end
  end

  raise "didn't ever terminate"
end


if __FILE__ == $0
  instructions = parse_instructions(File.read("input/day8").lines)

  part1_result = execute_instructions(instructions)
  puts "part 1 result: acc = #{part1_result.acc}"

  part2_result = day8_part2(instructions, part1_result)
  puts "part 2 result: acc = #{part2_result.acc}"
end
