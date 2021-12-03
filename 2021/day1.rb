test_data = [
  199,
  200,
  208,
  210,
  200,
  207,
  240,
  269,
  260,
  263
]

def amount_increased(data)
  data.each_cons(2).count { _1.last > _1.first }
end

# step 1 test data
puts amount_increased(test_data)

input = File.read("input/day1").split.map(&:to_i)

# step 1
puts amount_increased(input) # 1713

# step 2
puts amount_increased(input.each_cons(3).map(&:sum)) # 1734
