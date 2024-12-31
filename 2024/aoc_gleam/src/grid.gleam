import gleam/dict
import gleam/list
import gleam/result
import gleam/string

pub type Grid =
  dict.Dict(Int, dict.Dict(Int, String))

pub fn index_2d_input(input) -> Grid {
  string.split(input, "\n")
  |> list.map(string.split(_, ""))
  |> list.map(fn(line) { list.index_map(line, fn(x, i) { #(i, x) }) })
  |> list.map(dict.from_list)
  |> list.index_map(fn(x, i) { #(i, x) })
  |> dict.from_list
}

pub fn find_locations(grid, char_to_find) -> List(#(Int, Int)) {
  dict.fold(grid, [], fn(acc, row_index, row) {
    dict.fold(row, [], fn(acc, col_index, char) {
      case char == char_to_find {
        True -> list.append(acc, [#(row_index, col_index)])
        False -> acc
      }
    })
    |> list.append(acc, _)
  })
}

pub fn get_at(grid: Grid, idx: #(Int, Int)) -> Result(String, Nil) {
  dict.get(grid, idx.0) |> result.try(dict.get(_, idx.1))
}

pub fn set_at(grid: Grid, idx: #(Int, Int), value: String) -> Grid {
  dict.get(grid, idx.0)
  |> result.unwrap(dict.new())
  |> dict.insert(idx.1, value)
  |> dict.insert(grid, idx.0, _)
}
