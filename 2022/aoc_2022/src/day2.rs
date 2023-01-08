use std::collections::HashMap;

const BONUSES: [(&str, i32); 6] = [("A", 1), ("B", 2), ("C", 3), ("X", 1), ("Y", 2), ("Z", 3)];

fn parse_and_score(score: fn(&str, &str) -> i32) -> i32 {
    std::fs::read_to_string("inputs/day2")
        .unwrap()
        .split('\n')
        .map(|game| game.split(' '))
        .map(|mut moves| score(moves.next().unwrap(), moves.next().unwrap()))
        .sum()
}

pub fn part1() {
    let score = |their_move: &str, my_move: &str| {
        let wins = [("A", "Y"), ("B", "Z"), ("C", "X")];
        let draws = [("A", "X"), ("B", "Y"), ("C", "Z")];
        let bonuses = HashMap::from(BONUSES);

        let bonus = bonuses.get(my_move).unwrap();

        let score = match (their_move, my_move) {
            m if draws.iter().any(|mv| *mv == m) => 3,
            m if wins.iter().any(|mv| *mv == m) => 6,
            _ => 0,
        };

        bonus + score
    };

    println!("d2 p1: {}", parse_and_score(score));
}

pub fn part2() {
    let score = |their_move: &str, desired_outcome: &str| {
        let wins = HashMap::from([("A", "B"), ("B", "C"), ("C", "A")]);
        let losses = HashMap::from([("A", "C"), ("B", "A"), ("C", "B")]);
        let bonuses = HashMap::from(BONUSES);

        match desired_outcome {
            "X" => *bonuses.get(losses.get(their_move).unwrap()).unwrap(),
            "Y" => bonuses.get(their_move).unwrap() + 3,
            "Z" => bonuses.get(wins.get(their_move).unwrap()).unwrap() + 6,
            _ => panic!("unexpected input"),
        }
    };

    println!("d2 p2: {}", parse_and_score(score));
}
