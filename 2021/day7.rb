test_input = "16,1,2,0,4,2,7,1,2,14"

input = File.read("input/day7")
#input = test_input

positions = input.split(',').map(&:to_i)


# part 1

median = positions.sort[positions.length / 2]

total_fuel = positions.map { (_1 - median).abs }.sum

puts "target: #{median}, total_fuel: #{total_fuel}"


# part 2

def total_fuel_increasing(target, positions)
  positions.map { _1 - target }.map(&:abs).map { (1.._1).sum }.sum
end

# if I change `round` to `floor` this gives me the correct answer
# though I am not sure why
avg = (positions.sum.to_f / positions.length).round

total_fuel = total_fuel_increasing(avg, positions)

# 👆 that didn't work so...
# just go over a wide range of possibilities somewhere in the middle
brute_force = (400..600).map { |target| total_fuel_increasing(target, positions) }.min

puts "target: #{avg}, total_fuel: #{total_fuel}, brute_force: #{brute_force}"

