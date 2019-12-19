defmodule AdventOfCode.Day02 do
  defmodule Intcode do
    @add 1
    @multiply 2
    @done 99

    def run(input, address) do
      opcode = input[address]

      case run_opcode(input, opcode, address) do
        {:done, val} ->
          val

        {:updated, updated_input} ->
          run(updated_input, address + 4)

        {:invalid_opcode} ->
          # i guess?
          nil
      end
    end

    defp run_opcode(%{0 => val}, @done, _) do
      {:done, val}
    end

    defp run_opcode(input = %{}, @add, address) do
      val = input[input[address + 1]] + input[input[address + 2]]
      {:updated, Map.put(input, input[address + 3], val)}
    end

    defp run_opcode(input = %{}, @multiply, address) do
      val = input[input[address + 1]] * input[input[address + 2]]
      {:updated, Map.put(input, input[address + 3], val)}
    end

    defp run_opcode(_input, _opcode, _address) do
      {:invalid_opcode}
    end
  end

  def part1(args) do
    input = args
      |> String.trim
      |> String.split(",")
      |> Enum.map(fn(val) -> {intVal, ""} = Integer.parse(val); intVal end)
      |> list_to_map
      |> Map.put(1, 12)
      |> Map.put(2, 2)

    output = Intcode.run(input, 0)

    IO.puts("Output: #{output}")
  end

  def part2([args, desired_output]) do
    input_map = args
      |> String.trim
      |> String.split(",")
      |> Enum.map(fn(val) -> {intVal, ""} = Integer.parse(val); intVal end)
      |> list_to_map

    result = for noun <- 0..100,
        verb <- 0..100 do
          input =
          input_map
          |> Map.put(1, noun)
          |> Map.put(2, verb)

          output = Intcode.run(input, 0)

          if output == desired_output do
            {noun, verb}
          end
    end

    result
    |> Enum.reject(&is_nil/1)
    |> List.first
  end

  def list_to_map(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {i, index} -> {index, i} end)
    |> Map.new()
  end
end
