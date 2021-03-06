# typed: false
# Part 1

puts File.read("input/day6")
  .split("\n\n")
  .map { _1.tr("\n", '').chars.uniq.count }
  .sum


# Part 2

puts File.read("input/day6")
  .split("\n\n")
  .map { _1.lines.map(&:chomp).map(&:chars).reduce(&:&).count }
  .sum
