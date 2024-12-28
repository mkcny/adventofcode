import gleam/dict
import gleam/function
import gleam/int
import gleam/list
import gleam/order
import gleam/result
import gleam/string
import simplifile

fn parse_reports() {
  use input <- result.map(simplifile.read("input/day2"))

  input
  |> string.split("\n")
  |> list.map(string.split(_, " "))
  |> list.map(list.filter_map(_, int.parse(_)))
}

pub fn step1() {
  use reports <- result.map(parse_reports())
  list.count(reports, safe)
}

pub fn step2() {
  use reports <- result.map(parse_reports())
  list.count(reports, fn(report) { safe(report) || safe_variant(report) })
}

fn safe_variant(report: List(Int)) -> Bool {
  report
  |> list.index_map(fn(_, i) {
    let #(left, right) = list.split(report, i)
    list.append(left, list.drop(right, 1))
  })
  |> list.find(safe)
  |> result.is_ok
}

fn safe(report: List(Int)) -> Bool {
  all_increasing_or_decreasing(report) && levels_differ_within_tolerance(report)
}

fn all_increasing_or_decreasing(report: List(Int)) -> Bool {
  let comparisons =
    report
    |> list.window_by_2
    |> list.map(fn(pair) { int.compare(pair.0, pair.1) })
    |> list.group(function.identity)

  case dict.keys(comparisons) {
    [order.Gt] | [order.Lt] -> True
    _ -> False
  }
}

fn levels_differ_within_tolerance(report: List(Int)) -> Bool {
  report
  |> list.window_by_2
  |> list.map(fn(pair) { int.absolute_value(pair.0 - pair.1) })
  |> list.all(fn(x) { x >= 1 && x <= 3 })
}
