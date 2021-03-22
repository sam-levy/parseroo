defmodule Parseroo.Orders.Persist do
  alias Ecto.Multi

  alias Parseroo.Orders.{Address, Buyer, Item, Order, Payment, Shipment}
  alias Parseroo.Parsers.Params.OrderParams
  alias Parseroo.Repo

  def call(%OrderParams{
        buyer: buyer,
        address: address,
        order: order,
        shipment: shipment,
        items: items,
        payments: payments
      }) do
    Multi.new()
    |> Multi.insert(:buyer, buyer_changeset(buyer))
    |> Multi.insert(:address, address_changeset(address))
    |> Multi.insert(:order, &order_changeset(&1, order))
    |> Multi.insert(:shipment, &shipment_changeset(&1, shipment))
    |> Multi.insert_all(:items, Item, &build_params(&1, items))
    |> Multi.insert_all(:payments, Payment, &build_params(&1, payments))
    |> Repo.transaction()
    |> as_result()
  end

  defp buyer_changeset(buyer) do
    buyer |> Map.from_struct() |> Buyer.changeset()
  end

  defp address_changeset(address) do
    address |> Map.from_struct() |> Address.changeset()
  end

  defp order_changeset(%{buyer: buyer}, order) do
    %{order | buyer_id: buyer.id}
    |> Map.from_struct()
    |> Order.changeset()
  end

  defp shipment_changeset(%{address: address, order: order}, shipment) do
    %{shipment | order_id: order.id, receiver_address_id: address.id}
    |> Map.from_struct()
    |> Shipment.changeset()
  end

  defp build_params(%{order: order}, params_list) do
    now = DateTime.utc_now()

    Enum.map(params_list, fn params ->
      params
      |> Map.from_struct()
      |> Map.put(:order_id, order.id)
      |> Map.put(:inserted_at, now)
      |> Map.put(:updated_at, now)
    end)
  end

  defp as_result({:ok, %{order: order}}), do: {:ok, order}
  defp as_result({:error, _operation, reason, _changes}), do: {:error, reason}
end
