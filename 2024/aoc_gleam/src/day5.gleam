import gleam/bool
import gleam/int
import gleam/list
import gleam/result
import gleam/set
import gleam/string

fn convert_sublist_to_ints(sublist) {
  sublist |> list.map(int.parse) |> list.map(result.unwrap(_, 0))
}

fn parse_input(input) {
  let assert [rules, updates] = string.split(input, "\n\n")
  #(parse_section(rules, "|"), parse_section(updates, ","))
}

fn parse_section(section, split_by) {
  string.split(section, "\n")
  |> list.map(string.split(_, split_by))
  |> list.map(convert_sublist_to_ints)
}

fn update_is_correctly_ordered(update, rules) -> Bool {
  rules
  |> list.filter(rule_applies(update, _))
  |> list.all(rule_followed(update, _))
}

pub fn rule_applies(update: List(Int), rule: List(Int)) -> Bool {
  let assert [first, second] = rule
  list.contains(update, first) && list.contains(update, second)
}

pub fn rule_followed(update: List(Int), rule: List(Int)) -> Bool {
  let assert [first, second] = rule
  let #(_left, right) = list.split_while(update, fn(x) { x != first })

  list.contains(right, second)
}

pub fn get_middle_number(update: List(Int)) -> Int {
  list.drop(update, list.length(update) / 2)
  |> list.first
  |> result.unwrap(0)
}

pub fn step1(input) {
  let #(rules, updates) = parse_input(input)

  list.filter(updates, update_is_correctly_ordered(_, rules))
  |> list.map(get_middle_number)
  |> list.fold(0, int.add)
}

fn reorder(update, rules) {
  let rules = list.filter(rules, rule_applies(update, _))
  reorder_recursive(rules, [])
}

fn reorder_recursive(rules, reordered) {
  use <- bool.guard(when: rules == [], return: reordered)

  let assert [left, right] = list.transpose(rules) |> list.map(set.from_list)

  // find the number that is only ever specified as first in all remaining rules
  let next_num =
    set.difference(left, right)
    |> set.to_list
    |> list.first
    |> result.unwrap(0)

  // remove rules where the number we just got appears first
  let rules =
    list.filter(rules, fn(rule) {
      case rule {
        [left, _] if left == next_num -> False
        _ -> True
      }
    })

  // add the number we found to the reordered list, carry on and find the next number
  reorder_recursive(rules, list.append(reordered, [next_num]))
}

pub fn step2(input) {
  let #(rules, updates) = parse_input(input)

  list.filter(updates, fn(update) {
    !update_is_correctly_ordered(update, rules)
  })
  |> list.map(reorder(_, rules))
  |> list.map(get_middle_number)
  |> list.fold(0, int.add)
}
