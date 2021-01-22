defmodule Money.OperatorTest do
  use ExUnit.Case
  doctest Money.Operator

  use Money.Operator
  import Money.Sigils

  test "complex operator" do
    assert (~M[1000]THB + ~M[200]THB) * 2 == ~M[2400]THB
  end

  test "'/' operator" do
    assert ~M[200000]THB / 2 == ~M[100000]THB
    assert ~M[1000]DJF / 2 == ~M[500]DJF
  end
end
