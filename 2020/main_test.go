package main

import "testing"

func TestCountAllPaths(t *testing.T) {
	input := []int{0, 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, 22}
	result := countAllPaths(input, 0)

	if result != 8 {
		t.Errorf("Sum was %d, wanted %d.", result, 8)
		t.Fail()
	}

	result = countAllPaths(input, 7)

	if result != 1 {
		t.Errorf("Sum was %d, wanted %d.", result, 1)
		t.Fail()
	}
}
