/*
  Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

  For example:
    For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
    For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
    For a mass of 1969, the fuel required is 654.
    For a mass of 100756, the fuel required is 33583.
*/

package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	fuel_acc := 0
	// open the file
	file, err := os.Open("day_1_input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	// read every line and calc the fuel
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		mass, err := strconv.Atoi(scanner.Text())
		if err != nil {
			log.Fatal(err)
		}
		fuel_acc += calc_fuel(mass)
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	// tell us the final fuel count
	fmt.Printf("Total fuel: %v \n", fuel_acc)
}

// for dev / testing
func display_calc(mass int, fuel int) {
	fmt.Printf("Mass: %v \n", mass)
	fmt.Printf("Fuel: %v \n", fuel)
}

func calc_fuel(mass int) int {
	return mass/3 - 2
}
