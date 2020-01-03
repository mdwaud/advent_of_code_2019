defmodule AdventOfCode.Day03 do
  defmodule WireTracer do
    # returns a list of tuples for all the coordinates a wire passes
    def trace(trace_inputs) do
      trace_inputs
      |> Enum.reduce([{0,0}], fn(trace_input, acc) -> add_wire(trace_input, acc) end)
    end

    def add_wire({_direction, 0}, accumulator), do: accumulator
    def add_wire({direction, distance}, accumulator) do
      [current_coordinates | _] = accumulator # current position is the head of the list
      new_coordinates = step(current_coordinates, direction)
      add_wire({direction, distance - 1}, [new_coordinates | accumulator])
    end

    defp step({x,y}, "L"), do: {x-1,y}
    defp step({x,y}, "R"), do: {x+1,y}
    defp step({x,y}, "U"), do: {x,y-1}
    defp step({x,y}, "D"), do: {x,y+1}
  end

  def part1(input) do
    [input_1, input_2] = parse_input(input)

    wire_1 = WireTracer.trace(input_1)
    wire_2 = WireTracer.trace(input_2)

    find_closest_intersection(wire_1, wire_2)
  end

  def part2(input) do
    [input_1, input_2] = parse_input(input)

    wire_1 = WireTracer.trace(input_1)
    wire_2 = WireTracer.trace(input_2)

    find_fastest_intersection(wire_1, wire_2)
  end

  defp parse_input(input) when is_binary(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn(s) ->
      String.split(s, ",")
      |> Enum.map(fn(ss) ->
        <<direction::binary-1, distance_s::binary>> = ss
        distance = String.to_integer(distance_s)
        {direction, distance}
      end)
    end)
  end

  defp find_closest_intersection(wire_1, wire_2) do
    MapSet.intersection(MapSet.new(wire_1), MapSet.new(wire_2))
    |> Enum.reject(fn(coord) -> coord == {0,0} end)
    |> Enum.map(fn({x,y}) -> abs(x) + abs(y) end)
    |> Enum.min
  end

  defp find_fastest_intersection(wire_1, wire_2) do
    wire_1_map = make_step_map(wire_1)
    wire_2_map = make_step_map(wire_2)
    MapSet.intersection(MapSet.new(wire_1), MapSet.new(wire_2))
    |> Enum.reject(fn(coord) -> coord == {0,0} end)
    |> Enum.map(fn({x,y}) -> wire_1_map[{x,y}] + wire_2_map[{x,y}] end)
    |> Enum.min
  end

  defp make_step_map(wire) do
    wire
    |> Enum.reverse # this will have the nice side effect of taking the shortest distance
    |> Enum.with_index
    |> Map.new
  end
end
