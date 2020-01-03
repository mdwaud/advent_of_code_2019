defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03
  alias AdventOfCode.Day03.WireTracer

  describe "WireTracer#add_wire" do
    test "simple case" do
      assert [{1,0}, {0,0}] == WireTracer.add_wire({"R",1}, [{0,0}])
    end

    test "longer case" do
      assert [{-3,0},{-2,0},{-1,0}, {0,0}] == WireTracer.add_wire({"L",3}, [{0,0}])
    end
  end

  describe "WireTracer#trace" do
    test "simple case" do
      assert [{1,0}, {0,0}] == WireTracer.trace([{"R",1}])
    end

    test "longer case" do
      assert [{1,2},{1,1},{1,0}, {0,0}] == WireTracer.trace([{"R",1}, {"D",2}])
    end
  end

  describe "part 1" do
    test "example 1" do
      input =
"R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83"

      result = part1(input)

      assert 159 == result
    end
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
