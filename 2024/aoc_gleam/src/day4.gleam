import gleam/list
import gleam/result
import gleam/string
import grid
import simplifile

fn get_strings_for_offsets(
  indexed,
  indexes: List(#(Int, Int)),
  offsets_to_check: List(List(#(Int, Int))),
) {
  list.map(indexes, fn(idx) {
    list.map(offsets_to_check, fn(offsets) {
      list.map(offsets, fn(offset) { #(idx.0 + offset.0, idx.1 + offset.1) })
      |> list.filter_map(grid.get_at(indexed, _))
      |> list.fold("", string.append)
    })
  })
}

pub fn step1() {
  use input <- result.map(simplifile.read("input/day4"))
  let indexed = grid.parse_input(input)

  let x_indexes = grid.find_locations(indexed, "X")

  let offsets_to_check = [
    // up, down, sideways
    [#(1, 0), #(2, 0), #(3, 0)],
    [#(-1, 0), #(-2, 0), #(-3, 0)],
    [#(0, 1), #(0, 2), #(0, 3)],
    [#(0, -1), #(0, -2), #(0, -3)],
    // diagonals
    [#(1, 1), #(2, 2), #(3, 3)],
    [#(-1, -1), #(-2, -2), #(-3, -3)],
    [#(1, -1), #(2, -2), #(3, -3)],
    [#(-1, 1), #(-2, 2), #(-3, 3)],
  ]

  get_strings_for_offsets(indexed, x_indexes, offsets_to_check)
  |> list.flatten
  |> list.count(fn(str) { str == "MAS" })
}

pub fn step2() {
  use input <- result.map(simplifile.read("input/day4"))
  let indexed = grid.parse_input(input)

  let a_indexes = grid.find_locations(indexed, "A")

  let offsets_to_check = [[#(-1, 1), #(1, -1)], [#(-1, -1), #(1, 1)]]

  get_strings_for_offsets(indexed, a_indexes, offsets_to_check)
  |> list.count(list.all(_, fn(str) { str == "MS" || str == "SM" }))
}
