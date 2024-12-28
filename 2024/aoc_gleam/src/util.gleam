import gleam/dict
import gleam/function
import gleam/list

pub fn tally(l: List(t)) -> dict.Dict(t, Int) {
  l
  |> list.group(function.identity)
  |> dict.map_values(fn(_, value) { list.length(value) })
}
