# typed: strict
require 'sorbet-runtime'
extend T::Sig

sig { params(jolts: T::Array[Integer]).returns(Integer) }
def day10_part1(jolts)
  jolts.unshift(0)
  results = []

  jolts.each_index do |index|
    current = T.must(jolts[index])
    nxt = jolts[index + 1] || (current + 3)

    results << nxt - current
  end

  result = results.tally
  result.fetch(1) * result.fetch(3)
end

if __FILE__ == $0
  input = File.read("input/day10").lines.map(&:to_i).sort
  puts day10_part1(input)
end
