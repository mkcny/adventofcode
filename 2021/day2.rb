def get_position
  File.read("input/day2")
    .split("\n")
    .map(&:split)
    .map { { cmd: _1[0], val: _1[1].to_i } }
    .each_with_object(Hash.new(0)) { |inst, res| yield(inst[:cmd], inst[:val], res) }
end

result = get_position do |cmd, value, pos|
  case cmd
  when 'forward' then pos[:horizontal] += value
  when 'down' then pos[:depth] += value
  when 'up' then pos[:depth] -= value
  end
end

puts "result = #{result[:horizontal] * result[:depth]}"


# part 2

result = get_position do |cmd, value, pos|
  case cmd
  when 'forward'
    pos[:horizontal] += value
    pos[:depth] += (pos[:aim] * value)
  when 'down' then pos[:aim] += value
  when 'up' then pos[:aim] -= value
  end
end

puts "result = #{result[:horizontal] * result[:depth]}"
