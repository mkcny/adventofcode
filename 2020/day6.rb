puts File.read("day6-input")
  .split("\n\n")
  .map { _1.tr("\n", '').chars.uniq.count }
  .sum
