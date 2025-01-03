import gleam/dict
import gleam/int
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

fn get_all_antinode_locations_in_range(
  max: #(Int, Int),
  pair: #(#(Int, Int), #(Int, Int)),
) -> List(#(Int, Int)) {
  let #(a, b) = pair

  let delta = #(a.0 - b.0, a.1 - b.1)

  list.append(
    get_antinodes(max, a, delta, [], int.add),
    get_antinodes(max, b, delta, [], int.subtract),
  )
  |> list.append([a, b])
}

fn get_antinodes(
  max: #(Int, Int),
  pos: #(Int, Int),
  delta: #(Int, Int),
  acc: List(#(Int, Int)),
  op: fn(Int, Int) -> Int,
) -> List(#(Int, Int)) {
  let new_pos = #(op(pos.0, delta.0), op(pos.1, delta.1))

  case new_pos {
    #(x, y) if x < 0 || y < 0 || x > max.0 || y > max.1 -> acc
    _ -> get_antinodes(max, new_pos, delta, [new_pos, ..acc], op)
  }
}

pub fn step2(input) {
  let grid = grid.parse_input(input)
  let max = grid.get_size(grid)

  grid
  |> dict.values
  |> set.from_list
  |> set.delete(".")
  |> set.to_list
  |> list.flat_map(fn(char) {
    grid.find_locations(grid, char)
    |> list.combination_pairs
    |> list.map(get_all_antinode_locations_in_range(max, _))
  })
  |> list.flatten
  |> set.from_list
  |> set.size
}
