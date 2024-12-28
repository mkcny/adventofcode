input = File.read("day1_input")

cols = input.split.each_slice(2).to_a.transpose.map(&:sort)

distances = cols[0].zip(cols[1])
  .map { |(a, b)| a.to_i - b.to_i }
  .map(&:abs)

puts distances.sum

