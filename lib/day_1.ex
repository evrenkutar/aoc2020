defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day1.hello()
      :world

  """
  def checkFor2020([h | t]) do
    l = 2020 - h

    if Enum.member?(t, l) do
      h * l
    else
      checkFor2020(t)
    end
  end

  defmodule M do
    def c([head | tail], leftover) do
      # stdout variables
      # IO.inspect binding()
      cond do
        Enum.member?(tail, leftover - head) ->
          {head, leftover - head}

        Enum.member?(tail, head - leftover) ->
          {head, head - leftover}

        true ->
          c(tail, leftover)
      end
    end

    def c([], _leftover) do
      {0, 0}
    end
  end

  def check3([h | t]) do
    l = 2020 - h
    # stdout variables
    # IO.inspect binding()
    r = M.c(t, l)

    if elem(r, 0) + elem(r, 1) + h == 2020 do
      h * elem(r, 0) * elem(r, 1)
    else
      check3(t)
    end
  end

  def processFile do
    {:ok, fileInput} = File.read("inputs/day1.txt")
    s = for n <- String.split(fileInput, "\n"), do: unless(n == "", do: String.to_integer(n))
    sNoNil = Enum.filter(s, &(!is_nil(&1)))
    # solution for first question
    checkFor2020(sNoNil)
    # solution for second question
    check3(sNoNil)
  end
end
