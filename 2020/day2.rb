# typed: false
require 'pry'

def parsed_lines
  File.read("input/day2").lines
    .map { _1.match(/(?<min>\d+)-(?<max>\d+) (?<char>[a-z]): (?<password>[a-z]+)/) }
    .map { _1.named_captures.transform_keys!(&:to_sym) }
    .map { _1.merge({min: _1[:min].to_i, max: _1[:max].to_i}) }
end

puts parsed_lines
  .map { _1.merge({count: _1[:password].chars.count(_1[:char])}) }
  .count { _1[:count] >= _1[:min] && _1[:count] <= _1[:max] }

puts parsed_lines
  .map { _1.merge({chars: _1[:password].chars.values_at(_1[:min]-1, _1[:max]-1)}) }
  .reject { _1[:chars][0] == _1[:chars][1] }
  .count { _1[:chars].any?(_1[:char]) }
