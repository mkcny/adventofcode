import gleam/deque
import gleam/int
import gleam/list
import gleam/pair
import gleam/string

pub fn get_blocks(input) {
  string.to_graphemes(input)
  |> list.filter_map(int.parse)
  |> list.index_fold(#(deque.new(), 0), fn(acc, size, index) {
    let #(blocks, file_id) = acc
    let #(char, file_id) = case index % 2 {
      0 -> #(int.to_string(file_id), file_id + 1)
      _ -> #(".", file_id)
    }
    #(list.repeat(char, size) |> list.fold(blocks, deque.push_back), file_id)
  })
  |> pair.first
}

pub fn compact(blocks, acc) {
  case deque.pop_front(blocks) {
    Ok(#(".", blocks)) -> {
      case get_from_end(blocks) {
        Ok(#(char, blocks)) -> compact(blocks, acc <> char)
        _ -> acc
      }
    }
    Ok(#(char, blocks)) -> compact(blocks, acc <> char)
    _ -> acc
  }
}

pub fn get_from_end(blocks) {
  case deque.pop_back(blocks) {
    Ok(#(".", blocks)) -> get_from_end(blocks)
    x -> x
  }
}

pub fn checksum(compacted) {
  string.to_graphemes(compacted)
  |> list.filter_map(int.parse)
  |> list.index_fold(0, fn(acc, num, i) { acc + { num * i } })
}

pub fn step1(input) {
  get_blocks(input) |> compact("") |> checksum
}
