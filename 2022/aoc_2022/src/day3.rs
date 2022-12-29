use std::collections::HashSet;

pub fn part1() {
    let sum: u32 = std::fs::read_to_string("inputs/day3")
        .unwrap()
        .split("\n")
        .map(|line| line.split_at(line.len() / 2))
        .map(|(a, b)| find_common_char(vec![a, b]))
        .map(|c| get_priority(c))
        .sum();

    println!("d3 p1: {}", sum);
}

fn get_priority(c: char) -> u32 {
    let offset = if c.is_lowercase() { 96 } else { 38 };
    c as u32 - offset
}

pub fn part2() {
    let sum: u32 = std::fs::read_to_string("inputs/day3")
        .unwrap()
        .split("\n")
        .collect::<Vec<&str>>()
        .array_chunks::<3>()
        .map(|triple| find_common_char(triple.to_vec()))
        .map(|c| get_priority(c))
        .sum();

    println!("d3 p2: {}", sum);
}

fn find_common_char(strs: Vec<&str>) -> char {
    strs.iter()
        .map(|s| s.chars().collect::<HashSet<char>>())
        .reduce(|acc, e| acc.intersection(&e).copied().collect::<HashSet<char>>())
        .unwrap()
        .iter()
        .next()
        .unwrap()
        .clone()
}
