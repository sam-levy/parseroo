defmodule Parseroo.Orders.FetchTest do
  use Parseroo.DataCase, async: true

  alias Ecto.UUID
  alias Parseroo.Orders
  alias Parseroo.Orders.{Address, Buyer, Item, Order, Payment, Shipment}

  describe "call/1" do
    test "fetches an order and its preloads" do
      buyer = insert(:buyer)
      order = insert(:order, buyer: buyer)
      address = insert(:address)

      insert(:item, order: order)
      insert(:payment, order: order)
      insert(:shipment, order: order, receiver_address: address)

      assert {:ok, %Order{} = return} = Orders.fetch(order.id)

      assert %Buyer{} = return.buyer
      assert %Shipment{} = return.shipment
      assert %Address{} = return.shipment.receiver_address
      assert [%Payment{}] = return.payments
      assert [%Item{}] = return.items
    end

    test "when order does not exist" do
      assert {:error, :not_found} = Orders.fetch(UUID.generate())
    end
  end
end
