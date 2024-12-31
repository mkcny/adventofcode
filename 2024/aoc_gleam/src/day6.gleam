import gleam/bool
import gleam/dict
import gleam/list
import gleam/result
import gleam/set
import grid

type Move {
  Up
  Down
  Left
  Right
}

fn turn_right(move: Move) -> Move {
  case move {
    Up -> Right
    Right -> Down
    Down -> Left
    Left -> Up
  }
}

fn potential_next_pos(current_pos: #(Int, Int), move: Move) -> #(Int, Int) {
  case move {
    Up -> #(current_pos.0 - 1, current_pos.1)
    Down -> #(current_pos.0 + 1, current_pos.1)
    Left -> #(current_pos.0, current_pos.1 - 1)
    Right -> #(current_pos.0, current_pos.1 + 1)
  }
}

fn pos_out_of_bounds(grid: grid.Grid, pos: #(Int, Int)) -> Bool {
  let row_count = list.length(dict.values(grid))
  let col_count =
    grid
    |> dict.get(0)
    |> result.unwrap(dict.new())
    |> dict.values
    |> list.length

  pos.0 < 0 || pos.1 < 0 || pos.0 >= row_count || pos.1 >= col_count
}

fn pos_obstructed(grid: grid.Grid, pos: #(Int, Int)) -> Bool {
  case grid.get_at(grid, pos) {
    Ok("#") -> True
    _ -> False
  }
}

fn move_until_out_of_bounds(
  grid: grid.Grid,
  pos: #(Int, Int),
  direction: Move,
  visited_positions: set.Set(#(Int, Int)),
) -> set.Set(#(Int, Int)) {
  use <- bool.guard(
    when: pos_out_of_bounds(grid, pos),
    return: visited_positions,
  )

  let potential_next_pos = potential_next_pos(pos, direction)

  case pos_obstructed(grid, potential_next_pos) {
    True -> {
      move_until_out_of_bounds(
        grid,
        pos,
        turn_right(direction),
        visited_positions,
      )
    }
    False -> {
      move_until_out_of_bounds(
        grid,
        potential_next_pos,
        direction,
        set.insert(visited_positions, pos),
      )
    }
  }
}

pub fn step1(input) {
  let grid = grid.index_2d_input(input)

  let initial_pos =
    grid.find_locations(grid, "^")
    |> list.first
    |> result.unwrap(#(0, 0))

  move_until_out_of_bounds(grid, initial_pos, Up, set.new())
  |> set.size
}
