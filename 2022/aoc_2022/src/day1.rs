fn parse_input() -> Result<Vec<i32>, std::io::Error> {
    Ok(std::fs::read_to_string("inputs/day1")?
        .split("\n\n")
        .map(|elf| elf.split('\n').map(|s| s.parse::<i32>().unwrap()).sum())
        .collect())
}

pub fn part1() -> Result<(), std::io::Error> {
    let totals = parse_input()?;
    let highest = totals.iter().max().unwrap();

    println!("d1 p1: {}", highest);

    Ok(())
}

pub fn part2() -> Result<(), std::io::Error> {
    let mut totals = parse_input()?;

    totals.sort();
    totals.reverse();

    let answer: i32 = totals[0..3].iter().sum();

    println!("d1 p2: {}", answer);

    Ok(())
}