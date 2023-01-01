use std::ops::RangeInclusive;

fn count(filter: fn(&RangeInclusive<u32>, &RangeInclusive<u32>) -> bool) -> usize {
    std::fs::read_to_string("inputs/day4")
        .unwrap()
        .split("\n")
        .map(|line| parse_ranges(line))
        .filter(|[a, b]| filter(a, b))
        .count()
}

pub fn part1() {
    fn filter(a: &RangeInclusive<u32>, b: &RangeInclusive<u32>) -> bool {
        (a.contains(&b.start()) && a.contains(&b.end()))
            || (b.contains(&a.start()) && b.contains(&a.end()))
    }

    println!("d4 p1: {}", count(filter));
}

pub fn part2() {
    fn filter(a: &RangeInclusive<u32>, b: &RangeInclusive<u32>) -> bool {
        (a.contains(&b.start()) || a.contains(&b.end()))
            || (b.contains(&a.start()) || b.contains(&a.end()))
    }

    println!("d4 p2: {}", count(filter));
}

fn parse_ranges(line: &str) -> [RangeInclusive<u32>; 2] {
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
