defmodule Parceroo.Factory do
  use ExMachina.Ecto, repo: Parceroo.Repo

  def random_integer(range \\ 10..9999), do: Enum.random(range)

  def random_string_number, do: random_integer() |> to_string()
end
