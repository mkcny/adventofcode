mod day1;
mod day2;
mod day3;

fn main() -> Result<(), std::io::Error> {
    day1::part1();
    day1::part2();

    day2::part1();
    day2::part2();

    day3::part1();

    Ok(())
}
