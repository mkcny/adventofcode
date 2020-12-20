import * as fs from 'fs';

const numbers = fs.readFileSync('../input/day1','utf8')
    .split("\n")
    .map(s => parseInt(s))

// Part 1
const number = numbers.find(n1 => numbers.find(n2 => n1 + n2 == 2020)) ?? 0
console.log((2020-number) * number)

// Part 2 -- Slow version
console.log(
  (numbers
    .flatMap((n1, _, arr) => arr.flatMap(n2 => arr.map(n3 => [n1, n2, n3])))
    .find(nums => nums.reduce((acc, n) => acc + n) == 2020) ?? [])
    .reduce((n, acc) => acc * n)
)

// Part 2 -- Faster version
function findProduct(nums: number[]): number | void {
  for (let i = 0; i < nums.length; i++) {
    for (let j = i; j < nums.length; j++) {
      for (let k = j; k < nums.length; k++) {
        const [first, second, third] = [nums[i], nums[j], nums[k]]
        if (typeof first === "number" && typeof second === "number" && typeof third === "number") {
          if (first + second + third == 2020) {
            return first * second * third
          }
        }
      }
    }
  }
}
console.log(findProduct(numbers))