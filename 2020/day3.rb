data = File.read("day3-input").lines.map(&:chomp).map(&:chars)

def trees_hit(data, coordinates)
  coordinates.count { data[_1[0]][_1[1] % data[_1[0]].size] == "#" }
end

def coordinates(data, step_right, step_down)
  (0...data.length).step(step_down).zip((0..).step(step_right))
end

puts [[1,1], [3,1], [5,1], [7,1], [1,2]]
  .map { |step| trees_hit(data, coordinates(data, *step)) }
  .reduce(&:*)
