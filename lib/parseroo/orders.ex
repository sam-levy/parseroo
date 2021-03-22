defmodule Parseroo.Orders do
  @moduledoc """
  The Orders context.
  """

  alias Ecto.Multi
  alias Parseroo.Orders.{Address, Buyer, Item, Order, Payment, Shipment}
  alias Parseroo.Parsers.Params.OrderParams
  alias Parseroo.Repo

  def persist(%OrderParams{
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
    |> Multi.insert_all(:items, Item, &put_order_id(&1, items))
    |> Multi.insert_all(:payments, Payment, &put_order_id(&1, payments))
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
    Shipment.changeset(%{shipment | order_id: order.id, receiver_address_id: address.id})
  end

  defp put_order_id(%{order: order}, params_list) do
    Enum.map(params_list, &Map.from_struct(%{&1 | order_id: order.id}))
  end

  defp as_result({:ok, %{order: order}}), do: {:ok, order}
  defp as_result({:error, _operation, reason, _changes}), do: {:error, reason}
end
