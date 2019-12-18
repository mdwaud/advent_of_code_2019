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
	fuel := calc_fuel_for_modules()

	// tell us the final fuel count
	fmt.Printf("Total fuel: %v \n", fuel)
}

func calc_fuel_for_modules() int {
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
		fuel_acc += calc_fuel_for_module(mass)
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return fuel_acc
}

func calc_fuel_for_module(mass int) int {
	fuel := calc_fuel(mass)

	return calc_fuel_for_fuel(fuel, fuel)
}

func calc_fuel_for_fuel(fuel_mass int, fuel_acc int) int {
	if fuel_mass <= 0 {
		return fuel_acc
	} else {
		new_fuel := calc_fuel(fuel_mass)
		return calc_fuel_for_fuel(new_fuel, fuel_acc+new_fuel)
	}
}

// for dev / testing
func display_calc(mass int, fuel int) {
	fmt.Printf("Mass: %v \n", mass)
	fmt.Printf("Fuel: %v \n", fuel)
}

func calc_fuel(mass int) int {
	if mass <= 8 {
		return 0
	} else {
		return mass/3 - 2
	}
}
