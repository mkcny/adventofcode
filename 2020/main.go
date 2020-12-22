package main

import (
	"fmt"
	"io/ioutil"
	"sort"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
)

func main() {
	nums := getInput()
	fmt.Println(nums)

	fmt.Println(countAllPaths(nums, 0))
}

/*
func countAllPaths(jolts []int, start int) int {
	count := 1
	for i := start; i < len(jolts); i++ {
		toCheck := []int{i + 2, i + 3}
		fmt.Println("at index ", i, ". checking ", toCheck)
		for _, idx := range toCheck {
			if idx >= len(jolts) {
				break
			}
			fmt.Println("checking index ", idx)
			diff := jolts[idx] - jolts[i]
			if diff > 1 && diff <= 3 {
				result := countAllPaths(jolts, idx)
				fmt.Println(result)
				count = count + result
			}
		}
	}
	return count
}
*/

func countAllPaths(jolts []int, start int) uint64 {
	var wg sync.WaitGroup
	var count uint64 = 1

	for i := start; i < len(jolts); i++ {
		toCheck := []int{i + 2, i + 3}
		//fmt.Println("at index ", i, ". checking ", toCheck)
		for _, idx := range toCheck {
			if idx >= len(jolts) {
				break
			}
			//fmt.Println("checking index ", idx)
			diff := jolts[idx] - jolts[i]
			if diff > 1 && diff <= 3 {
				wg.Add(1)
				go func() {
					result := countAllPaths(jolts, idx)
					//fmt.Println(result)
					atomic.AddUint64(&count, result)
					wg.Done()
				}()
			}
		}
	}

	wg.Wait()

	return count
}

func getInput() []int {
	data, err := ioutil.ReadFile("input/day10")
	if err != nil {
		panic(err)
	}

	nums := []int{}

	for _, v := range strings.Split(string(data), "\n") {
		if v == "" {
			continue
		}
		num, err := strconv.Atoi(v)
		if err != nil {
			panic(err)
		}
		nums = append(nums, num)
	}

	sort.Ints(nums)

	nums = append([]int{0}, nums...)
	nums = append(nums, nums[len(nums)-1]+3)

	return nums
}
