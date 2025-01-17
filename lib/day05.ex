# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule Aoc2021.Day05 do
  def parse(args) do
    args |> Enum.map(fn x -> String.replace(x, " -> ",",") end)
         |> Enum.map(fn x -> String.split(x, ",") |> Enum.map(&String.to_integer/1) end)
  end

  def next(a, a), do: a
  def next(a, b), do: if a < b, do: a + 1, else: a - 1

  def plot([a, b, a, b], map), do: Map.update(map, {a, b}, 1, fn v -> v + 1 end)
  def plot([a, b, c, d], map), do: plot([next(a, c), next(b, d), c, d ], plot([a, b, a, b], map))

  def solve(l), do: Enum.reduce(l, %{}, &plot/2) |> Enum.count(fn {_,v} -> v > 1 end)

  def part1(args), do: parse(args) |> Enum.filter(fn [a,b,c,d] -> a == c or b == d end) |> solve()
  def part2(args), do: parse(args) |> solve()
end
