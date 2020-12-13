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


if __FILE__ == $0
  input = File.read("input/day9").lines.map(&:to_i)
  puts find_invalid_num(input, 25)
end
