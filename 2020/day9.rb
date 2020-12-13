# typed: strict
require 'sorbet-runtime'
extend T::Sig

sig { params(input: T::Array[Integer], preamble_size: Integer).returns(Integer) }
def find_invalid_num(input, preamble_size)
  index = preamble_size

  while value = input[index]
    start = index - preamble_size
    fin = index - 1
    nums = input.values_at(*(start..fin).to_a)

    result = nums.combination(2).any? { |pair| pair.sum == value }
    return value unless result

    index = index + 1
  end

  raise "no invalid numbers found"
end

sig { params(input: T::Array[Integer], preamble_size: Integer, sum_to_find: Integer).returns(Integer) }
def day9_part2(input, preamble_size, sum_to_find)
  index = 0

  while true
    range_size = 2
    loop do
      fin = index + range_size
      nums = input.values_at(*(index..fin).to_a)
      sum = nums.sum

      return nums.min + nums.max if sum == sum_to_find
      break if sum >= sum_to_find

      range_size = range_size + 1
    end

    index = index + 1
  end
end


if __FILE__ == $0
  input = File.read("input/day9").lines.map(&:to_i)

  part1_result = find_invalid_num(input, 25)
  puts "part 1 result: #{part1_result}"

  part2_result = day9_part2(input, 25, part1_result)
  puts "part 2 result: #{part2_result}"
end
