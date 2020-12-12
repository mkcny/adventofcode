# typed: true
def determine_row(seat)
  possible_rows = (0..127).to_a
  seat.first(7).each do |zone|
    if zone == 'F'
      possible_rows.pop(possible_rows.length / 2)
    elsif zone == 'B'
      possible_rows.shift(possible_rows.length / 2)
    end
  end

  raise unless possible_rows.length == 1
  return possible_rows.first
end

def determine_column(seat)
  possible_columns = (0..7).to_a
  seat.last(3).each do |zone|
    if zone == 'L'
      possible_columns.pop(possible_columns.length / 2)
    elsif zone == 'R'
      possible_columns.shift(possible_columns.length / 2)
    end
  end

  raise unless possible_columns.length == 1
  return possible_columns.first
end

seats = File.read("day5-input").lines.map(&:chomp).map(&:chars)
ids = []

seats.map do |seat|
  row = determine_row(seat)
  column = determine_column(seat)
  ids << row * 8 + column
  puts "Row: #{row}, Column: #{column}, ID: #{ids.last}"
end

puts "max id: #{ids.max}"
puts "my seat: #{(ids.min..ids.max).to_a - ids}"
