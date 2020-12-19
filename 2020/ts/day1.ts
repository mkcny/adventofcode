import * as fs from 'fs';

const numbers = fs.readFileSync('../input/day1','utf8')
    .split("\n")
    .map(s => parseInt(s))

const findSum = (nums: number[]) =>
  nums.reduce((acc, n) => acc + n) == 2020

// Part 1
console.log(
  (numbers
    .flatMap((n1, _, arr) => arr.map(n2 => [n1, n2]))
    .find(findSum) ?? [])
    .reduce((n, acc) => acc * n)
)

// Part 2
console.log(
  (numbers
    .flatMap((n1, _, arr) => arr.flatMap(n2 => arr.map(n3 => [n1, n2, n3])))
    .find(findSum) ?? [])
    .reduce((n, acc) => acc * n)
)
