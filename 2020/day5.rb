seats = File.read("day5-input").lines.map(&:chomp).map(&:chars)

ids = []

seats.map do |seat|
  possible_rows = (0..127).to_a
  seat.first(7).each do |zone|
    if zone == 'F'
      possible_rows.pop(possible_rows.length / 2)
    elsif zone == 'B'
      possible_rows.shift(possible_rows.length / 2)
    end
  end

  row = possible_rows.first

  possible_columns = (0..7).to_a
  seat.last(3).each do |zone|
    if zone == 'L'
      possible_columns.pop(possible_columns.length / 2)
    elsif zone == 'R'
      possible_columns.shift(possible_columns.length / 2)
    end
  end

  column = possible_columns.first
  id = row * 8 + column
  ids << id

  puts "Row: #{row}, Column: #{column}, ID: #{id}"

end

puts "max id: #{ids.max}"
