defmodule Day1 do
  def combinations([h|t]), do: (for x <- t, do: [h, x]) ++ combinations(t)
  def combinations([]), do: []

  def combine_thrice(list) do
    for x <- list, y <- list, z <- list, do: [x, y, z]
  end
end

# Part 1

File.stream!("input/day1")
  |> Stream.map(&String.trim/1)
  |> Enum.map(&String.to_integer/1)
  |> Day1.combinations
  |> Enum.find(&(Enum.sum(&1) == 2020))
  |> Enum.reduce(&*/2)
  |> IO.inspect

# Part 2

File.stream!("input/day1")
  |> Stream.map(&String.trim/1)
  |> Enum.map(&String.to_integer/1)
  |> Day1.combine_thrice
  |> Enum.find(&(Enum.sum(&1) == 2020))
  |> Enum.reduce(&*/2)
  |> IO.inspect