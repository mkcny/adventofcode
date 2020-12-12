# typed: false
require 'pry'

puts File.read("input/day1")
  .split
  .map(&:to_i)
  .combination(3)
  .find { _1.sum == 2020 }
  .reduce(&:*)
