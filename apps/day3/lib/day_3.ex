defmodule DAY_3 do
  @moduledoc """
  Documentation for `DAY_3`.
  """

  @doc """
  """
  @spec getIx(any, any) :: any
  defmodule SlotRule do
    defstruct slot: 4, move: 3, skip: false
  end

  def getIx(len, slot) do
    if len >= slot do
      slot
    else
      getIx(len, slot - len)
    end
  end

  @spec checkTree(binary, any, any) :: any
  def checkTree(item, slot, treeCount) do
    iList = String.to_charlist(item)
    iTuple = List.to_tuple(iList)
    ix = getIx(length(iList), slot)
    e = elem(iTuple, ix - 1)

    if e == 35 do
      treeCount + 1
    else
      treeCount
    end
  end

  @spec checkForTreesRecursive(maybe_improper_list, any, any, any) :: any
  def checkForTreesRecursive([h | t], checker, slotRule, treeCount) do
    newTreeCount = checker.(h, slotRule.slot, treeCount)
    tt = if t == [], do: [], else: tl(t)
    ttt = if slotRule.skip, do: tt, else: t

    checkForTreesRecursive(
      ttt,
      checker,
      %SlotRule{slot: slotRule.slot + slotRule.move, move: slotRule.move, skip: slotRule.skip},
      newTreeCount
    )
  end

  def checkForTreesRecursive([], _, _, treeCount) do
    treeCount
  end

  @spec processFile :: number
  def processFile do
    {:ok, fileInput} = File.read("inputs/day3.txt")
    s = for n <- String.split(fileInput, "\n"), n != "", do: n
    [h | t] = s
    # checkForTreesRecursive(t, &DAY_3.checkTree/3, 4, 0)
    count3to1 = checkForTreesRecursive(t, &DAY_3.checkTree/3, %SlotRule{slot: 4}, 0)
    count1to1 = checkForTreesRecursive(t, &DAY_3.checkTree/3, %SlotRule{slot: 2, move: 1}, 0)
    count5to1 = checkForTreesRecursive(t, &DAY_3.checkTree/3, %SlotRule{slot: 6, move: 5}, 0)
    count7to1 = checkForTreesRecursive(t, &DAY_3.checkTree/3, %SlotRule{slot: 8, move: 7}, 0)

    count1to2 =
      checkForTreesRecursive(t, &DAY_3.checkTree/3, %SlotRule{slot: 2, move: 1, skip: true}, 0)

    IO.inspect(binding())

    count1to2 * count1to1 * count3to1 * count5to1 * count7to1
  end
end
