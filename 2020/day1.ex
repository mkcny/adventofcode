defmodule Day1 do
  def combinations([h|t]), do: (for x <- t, do: [h, x]) ++ combinations(t)
  def combinations([]), do: []
end

File.read!("input/day1")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Day1.combinations
  |> Enum.find(&(Enum.sum(&1) == 2020))
  |> Enum.reduce(&*/2)
  |> IO.inspect