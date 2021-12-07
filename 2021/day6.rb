test_input = "3,4,3,1,2"
# input = test_input
input = File.read("input/day6")

timers = input.split(',').map(&:to_i).tally

256.times do
  timers = timers.each_with_object({}) { |(t, c), h| h[t - 1] = c }

  if num_to_spawn = timers.delete(-1)
    timers[6] = timers.fetch(6, 0) + num_to_spawn
    timers[8] = num_to_spawn
  end
end

puts "count: #{timers.values.sum}"