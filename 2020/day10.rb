# typed: strict
require 'sorbet-runtime'
extend T::Sig

sig { params(jolts: T::Array[Integer]).returns(Integer) }
def day10_part1(jolts)
  results = []

  jolts.each_index do |index|
    current = T.must(jolts[index])
    nxt = jolts[index + 1] || break

    results << nxt - current
  end

  result = results.tally
  result.fetch(1) * result.fetch(3)
end

sig { params(jolts: T::Array[Integer], start_index: Integer, level: Integer).returns(Integer) }
def count_all_paths(jolts, start_index = 0, level = 0)
  count = 1
  (start_index...jolts.length).each do |index|
    range_start = index + 2
    range_end = index + 3
    range_end = jolts.length - 1 if range_end >= jolts.length

    (range_start..range_end).each do |i|
      diff = jolts.fetch(i) - jolts.fetch(index)
      if diff > 1 && diff <= 3
        result = count_all_paths(jolts, i, level + 1)
        count = count + result
      end
    end
  end
  return count
end

if __FILE__ == $0
  input = File.read("input/day10").lines.map(&:to_i).sort.unshift(0)
  input.push(T.must(input.last) + 3)
  puts "part 1: #{day10_part1(input)}"
  puts "part 2: #{count_all_paths(input)}"
end
