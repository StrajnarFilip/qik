defmodule QikTest do
  use ExUnit.Case
  import Qik

  test "split_by test number list" do
    assert split_by([4, 5, 6, 7, 1, 5, 5, 5, 5, 1, 9, 8, 7, 3], 1) == [
             [4, 5, 6, 7],
             [5, 5, 5, 5],
             [9, 8, 7, 3]
           ]
  end

  test "split_by test graphemes" do
    assert split_by("a different type of split" |> String.graphemes(), " ") == [
             ["a"],
             ["d", "i", "f", "f", "e", "r", "e", "n", "t"],
             ["t", "y", "p", "e"],
             ["o", "f"],
             ["s", "p", "l", "i", "t"]
           ]
  end

  test "split_by on charlist" do
    assert split_by('abcd1efgh1ijkl1mnop', ?1) == ['abcd', 'efgh', 'ijkl', 'mnop']
  end

  test "indexes test 1" do
    assert indexes([6, 7, 8]) == 0..2
  end

  test "indexes test 2" do
    assert indexes(["one", "two", "three", "four"]) == 0..3
  end
end
