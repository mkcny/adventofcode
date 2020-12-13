# typed: strict
require 'sorbet-runtime'
extend T::Sig

sig { params(input: T::Array[Integer], preamble_size: Integer).returns(Integer) }
def find_invalid_num(input, preamble_size)
  (preamble_size...input.length).each do |index|
    value = input.fetch(index)
    range = ((index - preamble_size)..(index - 1))
    prev_nums = input.values_at(*range.to_a)

    result = prev_nums.combination(2).any? { |pair| pair.sum == value }
    return value unless result
  end

  raise "no invalid numbers found"
end

sig { params(input: T::Array[Integer], preamble_size: Integer, sum_to_find: Integer).returns(Integer) }
def day9_part2(input, preamble_size, sum_to_find)
  input.each_index do |index|
    (2...input.length).each do |range_size|
      range = (index..(index + range_size))
      nums = input.values_at(*range.to_a)

      return nums.min + nums.max if nums.sum == sum_to_find
      break if nums.sum >= sum_to_find
    end
  end

  raise "not found"
end


if __FILE__ == $0
  input = File.read("input/day9").lines.map(&:to_i)

  part1_result = find_invalid_num(input, 25)
  puts "part 1 result: #{part1_result}"

  part2_result = day9_part2(input, 25, part1_result)
  puts "part 2 result: #{part2_result}"
end
