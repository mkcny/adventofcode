import gleam/dict
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Grid(a) =
  dict.Dict(#(Int, Int), a)

pub fn parse_input(input) -> Grid(String) {
  string.split(input, "\n")
  |> list.map(string.split(_, ""))
  |> list.index_fold([], fn(acc, row, row_i) {
    list.index_map(row, fn(col, col_i) { #(#(row_i, col_i), col) })
    |> list.append(acc)
  })
  |> dict.from_list
}

pub fn get_size(grid: Grid(a)) -> #(Int, Int) {
  let x_size =
    grid
    |> dict.keys
    |> list.map(fn(x) { x.0 })
    |> list.max(int.compare)
    |> result.unwrap(0)

  let y_size =
    grid
    |> dict.keys
    |> list.map(fn(x) { x.1 })
    |> list.max(int.compare)
    |> result.unwrap(0)

  #(x_size, y_size)
}

pub fn find_locations(grid, char_to_find) -> List(#(Int, Int)) {
  dict.to_list(grid)
  |> list.filter(fn(entry) { entry.1 == char_to_find })
  |> list.map(fn(entry) { entry.0 })
}

pub fn find(grid, char_to_find) -> #(Int, Int) {
  dict.to_list(grid)
  |> list.find(fn(entry) { entry.1 == char_to_find })
  |> result.map(fn(entry) { entry.0 })
  |> result.unwrap(#(0, 0))
}

pub fn get_at(grid: Grid(a), idx: #(Int, Int)) -> Result(a, Nil) {
  dict.get(grid, idx)
}

pub fn set_at(grid: Grid(a), idx: #(Int, Int), value: a) -> Grid(a) {
  dict.insert(grid, idx, value)
}
