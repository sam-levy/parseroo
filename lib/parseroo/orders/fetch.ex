defmodule Parseroo.Orders.Fetch do
  alias Parseroo.Orders.Order
  alias Parseroo.Repo

  def call(id) do
    Order
    |> Repo.get(id)
    |> Repo.preload([:items, :payments, :buyer, shipment: [:receiver_address]])
    |> as_result()
  end

  defp as_result(nil), do: {:error, :not_found}
  defp as_result(order), do: {:ok, order}
end
