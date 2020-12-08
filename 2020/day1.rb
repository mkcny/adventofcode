require 'pry'

puts File.read("day1-input")
  .split
  .map(&:to_i)
  .combination(3)
  .find { _1.sum == 2020 }
  .reduce(&:*)
