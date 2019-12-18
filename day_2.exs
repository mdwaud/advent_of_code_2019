# Here are the initial and final states of a few more small programs:
#
#     1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2).
#     2,3,0,3,99 becomes 2,3,0,6,99 (3 * 2 = 6).
#     2,4,4,5,99,0 becomes 2,4,4,5,99,9801 (99 * 99 = 9801).
#     1,1,1,4,99,5,6,0,99 becomes 30,1,1,4,2,5,6,0,99.

input_list = [
  1,
  0,
  0,
  3,
  1,
  1,
  2,
  3,
  1,
  3,
  4,
  3,
  1,
  5,
  0,
  3,
  2,
  1,
  9,
  19,
  1,
  19,
  5,
  23,
  1,
  13,
  23,
  27,
  1,
  27,
  6,
  31,
  2,
  31,
  6,
  35,
  2,
  6,
  35,
  39,
  1,
  39,
  5,
  43,
  1,
  13,
  43,
  47,
  1,
  6,
  47,
  51,
  2,
  13,
  51,
  55,
  1,
  10,
  55,
  59,
  1,
  59,
  5,
  63,
  1,
  10,
  63,
  67,
  1,
  67,
  5,
  71,
  1,
  71,
  10,
  75,
  1,
  9,
  75,
  79,
  2,
  13,
  79,
  83,
  1,
  9,
  83,
  87,
  2,
  87,
  13,
  91,
  1,
  10,
  91,
  95,
  1,
  95,
  9,
  99,
  1,
  13,
  99,
  103,
  2,
  103,
  13,
  107,
  1,
  107,
  10,
  111,
  2,
  10,
  111,
  115,
  1,
  115,
  9,
  119,
  2,
  119,
  6,
  123,
  1,
  5,
  123,
  127,
  1,
  5,
  127,
  131,
  1,
  10,
  131,
  135,
  1,
  135,
  6,
  139,
  1,
  10,
  139,
  143,
  1,
  143,
  6,
  147,
  2,
  147,
  13,
  151,
  1,
  5,
  151,
  155,
  1,
  155,
  5,
  159,
  1,
  159,
  2,
  163,
  1,
  163,
  9,
  0,
  99,
  2,
  14,
  0,
  0
]

desired_output = 19_690_720

defmodule Day2 do
  def part_1(input_list, noun, verb) do
    input =
      list_to_map(input_list)
      |> Map.put(1, noun)
      |> Map.put(2, verb)

    output = Intcode.run(input, 0)

    IO.puts("Output: #{output}")
  end

  def part_2(input_list, desired_output) do
    input_map = list_to_map(input_list)

    for noun <- 0..100,
        verb <- 0..100 do
      input =
        input_map
        |> Map.put(1, noun)
        |> Map.put(2, verb)

      output = Intcode.run(input, 0)

      if output == desired_output do
        IO.puts("noun: #{noun}, verb: #{verb}, output: #{output}")
        # todo: be more elixir-y
        throw(:break)
      end
    end

    IO.puts("Didn't find noun-verb combo for #{desired_output}")
  end

  defp list_to_map(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {i, index} -> {index, i} end)
    |> Map.new()
  end
end

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

# Day2.part_1(input_list, 12, 2)
Day2.part_2(input_list, desired_output)
