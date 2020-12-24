defmodule DAY_2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  @doc """
  """

  def validatorA(item) do
    cpoints = String.codepoints(elem(item, 2))
    extract = for n <- cpoints, n == elem(item, 1), do: n
    elem(elem(item, 0), 0) <= length(extract) and length(extract) <= elem(elem(item, 0), 1)
  end

  def validatorB(item) do
    cpoints = String.codepoints(elem(item, 2))
    cpTuple = List.to_tuple(cpoints)
    firstP = elem(elem(item, 0), 0)
    secondP = elem(elem(item, 0), 1)
    isFirst = elem(cpTuple, firstP - 1) == elem(item, 1)
    isSecond = elem(cpTuple, secondP - 1) == elem(item, 1)
    oneOf = (isFirst or isSecond) and not (isFirst and isSecond)
    IO.inspect(binding())
    oneOf
  end

  def validateRecursive([h | t], validator, validCount) do
    isValid = validator.(h)
    IO.inspect(binding())

    if isValid do
      validateRecursive(t, validator, validCount + 1)
    else
      validateRecursive(t, validator, validCount)
    end
  end

  def validateRecursive([], validator, validCount) do
    validCount
  end

  def toData(s) do
    sp = String.split(s)
    spt = List.to_tuple(sp)
    # IO.inspect binding()
    o = String.split(elem(spt, 0), "-")

    {{String.to_integer(List.first(o)), String.to_integer(List.last(o))},
     String.trim_trailing(elem(spt, 1), ":"), elem(spt, 2)}
  end

  def processFile do
    {:ok, fileInput} = File.read("inputs/day2.txt")
    s = for n <- String.split(fileInput, "\n"), n != "", do: toData(n)
    validateRecursive(s, &DAY_2.validatorB/1, 0)
  end
end
