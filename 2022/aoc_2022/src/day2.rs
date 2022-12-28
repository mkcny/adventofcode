const BONUSES: [(&str, i32); 6] = [("A", 1), ("B", 2), ("C", 3), ("X", 1), ("Y", 2), ("Z", 3)];

fn parse_and_score(score: fn(&str, &str) -> i32) -> Result<i32, std::io::Error> {
    Ok(std::fs::read_to_string("inputs/day2")?
        .split("\n")
        .map(|game| game.split(" "))
        .map(|mut moves| score(moves.next().unwrap(), moves.next().unwrap()))
        .sum())
}

fn find_bonus(mv: &str) -> i32 {
    *BONUSES
        .iter()
        .find(|(m, _b)| m.eq(&mv))
        .map(|(_m, b)| b)
        .unwrap()
}

pub fn part1() -> Result<(), std::io::Error> {
    let score = |their_move: &str, my_move: &str| {
        let wins = [("A", "Y"), ("B", "Z"), ("C", "X")];
        let draws = [("A", "X"), ("B", "Y"), ("C", "Z")];

        let bonus = find_bonus(my_move);

        let score = match (their_move, my_move) {
            m if draws.iter().any(|mv| *mv == m) => 3,
            m if wins.iter().any(|mv| *mv == m) => 6,
            _ => 0,
        };

        bonus + score
    };

    println!("d2 p1: {}", parse_and_score(score)?);

    Ok(())
}

pub fn part2() -> Result<(), std::io::Error> {
    let score = |their_move: &str, desired_outcome: &str| {
        let wins = [("A", "B"), ("B", "C"), ("C", "A")];
        let losses = [("A", "C"), ("B", "A"), ("C", "B")];

        match desired_outcome {
            // lose
            "X" => {
                let my_move = losses.iter().find(|(t, _)| *t == their_move).map(|(_, m)| m).unwrap();
                find_bonus(my_move)
            },

            // draw
            "Y" => find_bonus(their_move) + 3,

            // win
            "Z" => {
                let my_move = wins.iter().find(|(t, _)| *t == their_move).map(|(_, m)| m).unwrap();
                find_bonus(my_move) + 6
            },

            _ => unreachable!("unexpected input")
        }
    };

    println!("d2 p2: {}", parse_and_score(score)?);

    Ok(())
}
