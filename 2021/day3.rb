test_input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"

input = File.read("input/day3")

def parse_input(input)
  input.split("\n").map(&:chars)
end

def part1(input)
  tallied = parse_input(input).transpose.map(&:tally)
  gamma = tallied.map { _1.max_by { |_,v| v }.first }.join.to_i(2)
  epsilon = tallied.map { _1.min_by { |_,v| v }.first }.join.to_i(2)
  gamma * epsilon
end

puts "test result (should be 198): #{part1(test_input)}"
puts "result: #{part1(input)}"


# part 2

def part2(input, make_choice)
  parsed_input = parse_input(input)

  (0...parsed_input.first.length).each do |i|
    tallies = parsed_input.map {_1[i]}.tally
    parsed_input.select! { _1[i] == make_choice.(tallies["0"], tallies["1"]) }
    break if parsed_input.length == 1
  end

  parsed_input.first.join.to_i(2)
end

oxygen_choice = -> (zero_count, one_count) { zero_count > one_count ? "0" : "1" }
co2_choice = -> (zero_count, one_count) { one_count < zero_count ? "1" : "0" }

puts "part2 test for oxygen (should be 23): #{part2(test_input, oxygen_choice)}"
puts "part2 test for co2 (should be 10): #{part2(test_input, co2_choice)}"

p2_oxygen = part2(input, oxygen_choice)
p2_co2 = part2(input, co2_choice)

puts "part2 for oxygen: #{p2_oxygen}"
puts "part2 for co2: #{p2_co2}"
puts "part2 final result: #{p2_oxygen * p2_co2}"