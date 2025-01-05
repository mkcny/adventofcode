import gleam/deque
import gleam/int
import gleam/list
import gleam/pair
import gleam/string

fn get_blocks(input) {
  string.to_graphemes(input)
  |> list.filter_map(int.parse)
  |> list.index_fold(#(deque.new(), 0), fn(acc, size, index) {
    let #(blocks, file_id) = acc
    let #(num, file_id) = case index % 2 {
      0 -> #(file_id, file_id + 1)
      _ -> #(-1, file_id)
    }
    #(list.repeat(num, size) |> list.fold(blocks, deque.push_back), file_id)
  })
  |> pair.first
}

fn compact(blocks, acc) {
  case deque.pop_front(blocks) {
    Ok(#(-1, blocks)) -> {
      case get_from_end(blocks) {
        Ok(#(num, blocks)) -> compact(blocks, deque.push_back(acc, num))
        _ -> acc
      }
    }
    Ok(#(num, blocks)) -> compact(blocks, deque.push_back(acc, num))
    _ -> acc
  }
}

fn get_from_end(blocks) {
  case deque.pop_back(blocks) {
    Ok(#(-1, blocks)) -> get_from_end(blocks)
    x -> x
  }
}

fn checksum(compacted) {
  compacted
  |> deque.to_list
  |> list.index_fold(0, fn(acc, num, i) { acc + { num * i } })
}

pub fn step1(input) {
  get_blocks(input) |> compact(deque.new()) |> checksum
}
