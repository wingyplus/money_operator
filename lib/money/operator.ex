defmodule Money.Operator do
  @moduledoc """
  Elixir arithmatic implementation for Money.
  """

  @doc """
  A short version of `Money.add/2`.

  ## Examples

    iex> use Money.Operator
    iex> import Money.Sigils
    iex> ~M[1000]THB + ~M[2530]THB
    %Money{amount: 3530, currency: :THB}
  """
  def a + b do
    Money.add(a, b)
  end

  @doc """
  A short version of `Money.subtract/2`.

  ## Examples

    iex> use Money.Operator
    iex> import Money.Sigils
    iex> ~M[1000]THB - ~M[2530]THB
    %Money{amount: -1530, currency: :THB}
  """
  def a - b do
    Money.subtract(a, b)
  end

  @doc """
  A short version of `Money.multiply/2`.

  ## Examples

    iex> use Money.Operator
    iex> import Money.Sigils
    iex> ~M[2530]THB * 2
    %Money{amount: 5060, currency: :THB}
  """
  def a * b do
    Money.multiply(a, b)
  end

  @doc """
  Divide operator on Money. `a` should be `Money.t()` and `b` should be a number (integer or float).

  ## Examples

    iex> use Money.Operator
    iex> import Money.Sigils
    iex> ~M[20000]THB / 2
    %Money{amount: 10000, currency: :THB}
  """
  def a / b do
    if b == 0 do
      raise ArgumentError, "divide by zero"
    end

    exponent = a.currency |> Money.Currency.get!() |> Map.get(:exponent)

    a
    |> Money.to_decimal()
    |> Decimal.div(b)
    |> Decimal.mult(:math.pow(10, exponent) |> trunc())
    |> Decimal.round()
    |> Decimal.to_integer()
    |> Money.new(a.currency)
  end

  defmacro __using__(_opts) do
    quote do
      import Money.Operator
      import Kernel, except: [+: 2, -: 2, *: 2, /: 2]
    end
  end
end
