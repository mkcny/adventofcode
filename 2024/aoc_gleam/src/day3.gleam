import gleam/int
import gleam/list
import gleam/option
import gleam/regexp
import gleam/result
import simplifile

pub fn step1() {
  use input <- result.map(simplifile.read("input/day3"))

  let assert Ok(re) = regexp.from_string("mul\\(([0-9]{1,3}),([0-9]{1,3})\\)")

  regexp.scan(re, input) |> sum_matches
}

fn sum_matches(matches: List(regexp.Match)) -> Int {
  matches
  |> list.map(fn(match) {
    let assert [a, b] =
      match.submatches
      |> list.map(fn(x) {
        option.unwrap(x, "0") |> int.parse() |> result.unwrap(0)
      })
    a * b
  })
  |> list.fold(0, int.add)
}

pub fn step2() {
  use input <- result.map(simplifile.read("input/day3"))

  let assert Ok(re) =
    regexp.from_string(
      "do\\(\\)|don't\\(\\)|mul\\(([0-9]{1,3}),([0-9]{1,3})\\)",
    )

  let matches = regexp.scan(re, input)

  get_until(matches, Dont, [])
  // i have a bug somewhere and need to filter out these "do" matches
  |> list.filter(match_do)
  |> sum_matches
}

type Action {
  Do
  Dont
}

fn get_until(
  matches: List(regexp.Match),
  action: Action,
  accumulator: List(regexp.Match),
) {
  case matches {
    [] -> accumulator
    _ -> {
      let match_fn = case action {
        Do -> match_do
        Dont -> match_dont
      }

      let #(left, right) = list.split_while(matches, match_fn)

      case action {
        // if we were looking for a 'Do', we can drop everything to the left and continue processing the right
        Do -> get_until(list.drop(right, 1), Dont, accumulator)
        // if we're looking for a "Don't" we save everything on the left and continue processing the right
        Dont -> {
          let accumulator = list.append(accumulator, left)
          get_until(list.drop(right, 1), Do, accumulator)
        }
      }
    }
  }
}

fn match_dont(match: regexp.Match) -> Bool {
  case match {
    regexp.Match("don't()", _) -> False
    _ -> True
  }
}

fn match_do(match: regexp.Match) -> Bool {
  case match {
    regexp.Match("do()", _) -> False
    _ -> True
  }
}
