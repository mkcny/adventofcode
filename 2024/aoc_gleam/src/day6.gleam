import gleam/bool
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

fn move_until_out_of_bounds(
  grid: grid.Grid,
  pos: #(Int, Int),
  direction: Move,
  visited_positions: set.Set(#(Int, Int)),
) -> set.Set(#(Int, Int)) {
  use <- bool.guard(
    when: grid.get_at(grid, pos) == Error(Nil),
    return: visited_positions,
  )

  let visited_positions = set.insert(visited_positions, pos)
  let potential_next_pos = potential_next_pos(pos, direction)

  let #(direction, next_pos) = case grid.get_at(grid, potential_next_pos) {
    Ok("#") -> #(turn_right(direction), pos)
    _ -> #(direction, potential_next_pos)
  }

  move_until_out_of_bounds(grid, next_pos, direction, visited_positions)
}

pub fn step1(input) {
  let grid = grid.parse_input(input)

  let initial_pos =
    grid.find_locations(grid, "^")
    |> list.first
    |> result.unwrap(#(0, 0))

  move_until_out_of_bounds(grid, initial_pos, Up, set.new())
  |> set.size
}

type ExitType {
  LoopDetected
  OutOfBounds
}

fn move_until_out_of_bounds_or_loop_detected(
  grid: grid.Grid,
  pos: #(Int, Int),
  direction: Move,
  visited_positions: set.Set(#(Int, Int, Move)),
) -> ExitType {
  use <- bool.guard(
    when: grid.get_at(grid, pos) == Error(Nil),
    return: OutOfBounds,
  )

  let newly_visited_pos = #(pos.0, pos.1, direction)

  use <- bool.guard(
    when: set.contains(visited_positions, newly_visited_pos),
    return: LoopDetected,
  )

  let visited_positions = set.insert(visited_positions, newly_visited_pos)
  let potential_next_pos = potential_next_pos(pos, direction)

  let #(direction, next_pos) = case grid.get_at(grid, potential_next_pos) {
    Ok("#") -> #(turn_right(direction), pos)
    _ -> #(direction, potential_next_pos)
  }

  move_until_out_of_bounds_or_loop_detected(
    grid,
    next_pos,
    direction,
    visited_positions,
  )
}

pub fn step2(input) {
  let grid = grid.parse_input(input)

  let initial_pos =
    grid.find_locations(grid, "^")
    |> list.first
    |> result.unwrap(#(0, 0))

  move_until_out_of_bounds(grid, initial_pos, Up, set.new())
  |> set.delete(initial_pos)
  |> set.to_list
  |> list.map(grid.set_at(grid, _, "#"))
  |> list.map(move_until_out_of_bounds_or_loop_detected(
    _,
    initial_pos,
    Up,
    set.new(),
  ))
  |> list.count(fn(exit_type) { exit_type == LoopDetected })
}
