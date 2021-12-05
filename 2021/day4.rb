require 'set'

test_input = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"

input = File.read("input/day4")
# input = test_input

selections = input.split("\n").first.split(',')
boards = input.split("\n\n")[1..].map { _1.split("\n") }.map { _1.map { |row| row.split(" ") } }

selection_set = selections.shift(4).to_set
winning_boards = []
latest_selection = nil
unwon_boards = boards

while winning_boards.length < boards.length
  latest_selection = selections.shift
  selection_set.add(latest_selection)

  new_winners, unwon_boards = unwon_boards.partition do |board|
    (board + board.transpose).map(&:to_set).any? { _1.to_set.subset?(selection_set) }
  end

  winning_boards += new_winners
  # break if winning_boards.any? # comment this out for part 2 solution
end

remaining_numbers = winning_boards.last.flatten.reject { selection_set.include?(_1) }
final_result = remaining_numbers.map(&:to_i).sum * latest_selection.to_i

puts "final result: #{final_result}"