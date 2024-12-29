import gleam/dict
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn step1() {
  use input <- result.map(simplifile.read("input/day4"))

  let indexed =
    string.split(input, "\n")
    |> list.map(string.split(_, ""))
    |> list.map(fn(line) { list.index_map(line, fn(x, i) { #(i, x) }) })
    |> list.map(dict.from_list)
    |> list.index_map(fn(x, i) { #(i, x) })
    |> dict.from_list

  let x_indexes =
    indexed
    |> dict.fold([], fn(acc, row_index, row) {
      row
      |> dict.fold([], fn(acc, col_index, char) {
        case char {
          "X" -> list.append(acc, [#(row_index, col_index)])
          _ -> acc
        }
      })
      |> list.append(acc, _)
    })

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

  list.flat_map(x_indexes, fn(idx) {
    list.map(offsets_to_check, fn(offsets) {
      list.map(offsets, fn(offset) { #(idx.0 + offset.0, idx.1 + offset.1) })
      |> list.filter_map(fn(pos_to_check) {
        dict.get(indexed, pos_to_check.0)
        |> result.map(dict.get(_, pos_to_check.1))
      })
      |> list.fold("", fn(str, res_char) {
        case res_char {
          Ok(char) -> str <> char
          _ -> str
        }
      })
    })
  })
  |> list.count(fn(str) { str == "MAS" })
}
