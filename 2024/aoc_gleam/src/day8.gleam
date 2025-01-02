import gleam/dict
import gleam/list
import gleam/set
import grid

fn get_antinode_locations(
  pair: #(#(Int, Int), #(Int, Int)),
) -> List(#(Int, Int)) {
  let #(a, b) = pair
  let dx = a.0 - b.0
  let dy = a.1 - b.1

  [#(a.0 + dx, a.1 + dy), #(b.0 - dx, b.1 - dy)]
}

pub fn step1(input) {
  let grid = grid.parse_input(input)

  let #(x_size, y_size) = grid.get_size(grid)

  grid
  |> dict.values
  |> set.from_list
  |> set.delete(".")
  |> set.to_list
  |> list.flat_map(fn(char) {
    grid.find_locations(grid, char)
    |> list.combination_pairs
    |> list.map(get_antinode_locations)
  })
  |> list.flatten
  |> list.filter(fn(pos) {
    pos.0 >= 0 && pos.0 <= x_size && pos.1 >= 0 && pos.1 <= y_size
  })
  |> set.from_list
  |> set.size
}
