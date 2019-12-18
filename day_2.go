/*
Here are the initial and final states of a few more small programs:

    1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2).
    2,3,0,3,99 becomes 2,3,0,6,99 (3 * 2 = 6).
    2,4,4,5,99,0 becomes 2,4,4,5,99,9801 (99 * 99 = 9801).
    1,1,1,4,99,5,6,0,99 becomes 30,1,1,4,2,5,6,0,99.
*/

package main

import (
	"fmt"
)

func main() {
	input := [...]int{1, 0, 0, 3, 1, 1, 2, 3, 1, 3, 4, 3, 1, 5, 0, 3, 2, 1, 9, 19, 1, 19, 5, 23, 1, 13, 23, 27, 1, 27, 6, 31, 2, 31, 6, 35, 2, 6, 35, 39, 1, 39, 5, 43, 1, 13, 43, 47, 1, 6, 47, 51, 2, 13, 51, 55, 1, 10, 55, 59, 1, 59, 5, 63, 1, 10, 63, 67, 1, 67, 5, 71, 1, 71, 10, 75, 1, 9, 75, 79, 2, 13, 79, 83, 1, 9, 83, 87, 2, 87, 13, 91, 1, 10, 91, 95, 1, 95, 9, 99, 1, 13, 99, 103, 2, 103, 13, 107, 1, 107, 10, 111, 2, 10, 111, 115, 1, 115, 9, 119, 2, 119, 6, 123, 1, 5, 123, 127, 1, 5, 127, 131, 1, 10, 131, 135, 1, 135, 6, 139, 1, 10, 139, 143, 1, 143, 6, 147, 2, 147, 13, 151, 1, 5, 151, 155, 1, 155, 5, 159, 1, 159, 2, 163, 1, 163, 9, 0, 99, 2, 14, 0, 0}
	desired_output := 19690720

	noun := 0
	verb := 0
Loop:
	for noun <= 100 {
		verb = 0
		for verb <= 100 {
			output := run_program(input, noun, verb)
			fmt.Printf("Ran - noun: %v, verb: %v, output: %v \n", noun, verb, output)
			if output == desired_output {
				break Loop
			}
			verb += 1
		}
		noun += 1
	}

	fmt.Printf("Found solution - noun: %v, verb: %v \n", noun, verb)
}

func run_program(input [173]int, noun int, verb int) int {
	input[1] = noun
	input[2] = verb
	index := 0
	val := -1

	// "run" the program
	for {
		val = input[index]
		switch val {
		case 1:
			// add
			input[input[index+3]] = input[input[index+1]] + input[input[index+2]]
			index += 4
		case 2:
			// multiply
			input[input[index+3]] = input[input[index+1]] * input[input[index+2]]
			index += 4
		case 99:
			return input[0]
		default:
			return -1
		}
	}
}
