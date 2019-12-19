defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02
  alias AdventOfCode.Day02.Intcode

  describe "Intcode" do
    test "#run" do
      input = "1,9,10,3,2,3,11,0,99,30,40,50"
      |> String.split(",")
      |> Enum.map(fn(val) -> {intVal, ""} = Integer.parse(val); intVal end)
      |> list_to_map

      result = Intcode.run(input, 0)

      assert result == 3500
    end
  end
end
