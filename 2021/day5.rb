test_input = "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"

# input = test_input
input = File.read("input/day5")

coordinate_pairs = input.split("\n")
  .map { _1.split(' -> ') }
  .map { |pair| pair.map { _1.split(',').map(&:to_i) } }

max = coordinate_pairs.flatten.max + 1
grid = Array.new(max) { Array.new(max, 0) }

coordinate_pairs.each do |coords|
  x1, y1 = coords[0]
  x2, y2 = coords[1]

  straight = x1 == x2 || y1 == y2
  diagonal = (x1 - x2).abs == (y1 - y2).abs

  next unless straight # || diagonal # include diagonals for part 2

  xs = x1 < x2 ? x1.upto(x2) : x1.downto(x2)
  ys = y1 < y2 ? y1.upto(y2) : y1.downto(y2)

  if straight
    xs.each { |x| ys.each { |y| grid[x][y] += 1 } }
  else
    xs.zip(ys).each { |x, y| grid[x][y] += 1 }
  end
end

puts "result: #{grid.flatten.select { _1 > 1 }.count}"