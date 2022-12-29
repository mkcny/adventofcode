use std::collections::HashSet;

pub fn part1() {
    let sum: u32 = std::fs::read_to_string("inputs/day3")
        .unwrap()
        .split("\n")
        .map(|line| line.split_at(line.len() / 2))
        .map(|(a, b)| find_common_char(a, b))
        .map(|c| get_priority(c))
        .sum();

    println!("d3 p1: {}", sum);
}

fn find_common_char(a: &str, b: &str) -> char {
    let set: HashSet<char> = a.chars().collect();
    b.chars().find(|x| set.contains(x)).unwrap()
}

fn get_priority(c: char) -> u32 {
    let offset = if c.is_lowercase() { 96 } else { 38 };
    c as u32 - offset
}