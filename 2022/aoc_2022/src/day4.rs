// use std::slice::range;

use std::ops::RangeInclusive;

pub fn part1() {
    let count = std::fs::read_to_string("inputs/day4")
        .unwrap()
        .split("\n")
        .map(|line| parse_ranges(line))
        .filter(|[a, b]| {
            (a.contains(&b.start()) && a.contains(&b.end()))
                || (b.contains(&a.start()) && b.contains(&a.end()))
        })
        .count();

    println!("d4 p1: {}", count);
}

pub fn parse_ranges(line: &str) -> [RangeInclusive<u32>; 2] {
    line.split(",")
        .map(|range_str| {
            range_str
                .split("-")
                .map(|s| s.parse::<u32>().unwrap())
                .next_chunk::<2>()
                .unwrap()
        })
        .map(|[a, b]| a..=b)
        .next_chunk::<2>()
        .unwrap()
}
