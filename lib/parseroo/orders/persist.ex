defmodule Parseroo.Orders.Persist do
  alias Ecto.Multi

  alias Parseroo.Orders.{Address, Buyer, Item, Order, Payment, Shipment}
  alias Parseroo.Parsers.Params.OrderParams
  alias Parseroo.Repo

  @on_conflict [
    on_conflict: {:replace_all_except, [:id, :inserted_at]},
    conflict_target: :external_id,
    returning: true
  ]

  def call(%OrderParams{
        buyer: buyer,
        address: address,
        order: order,
        shipment: shipment,
        items: items,
        payments: payments
      }) do
    Multi.new()
    |> Multi.insert(:buyer, buyer_changeset(buyer), @on_conflict)
    |> Multi.insert(:address, address_changeset(address), @on_conflict)
    |> Multi.insert(:order, &order_changeset(&1, order), @on_conflict)
    |> Multi.insert(:shipment, &shipment_changeset(&1, shipment), @on_conflict)
    |> Multi.insert_all(:items, Item, &build_params(&1, items), @on_conflict)
    |> Multi.insert_all(:payments, Payment, &build_params(&1, payments), @on_conflict)
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
