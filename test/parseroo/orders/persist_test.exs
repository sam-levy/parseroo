defmodule Parseroo.Orders.PersisTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Orders
  alias Parseroo.Orders.Order

  describe "call/1" do
    test "persists all schemas from order params" do
      order_params = BigMktPlaceFactory.params()

      assert {:ok, %Order{}} = Orders.persist(order_params)
    end

    test "updates schemas when order already exists" do
      insert_params = BigMktPlaceFactory.params(order_status: "payment_pending")
      updated_params = BigMktPlaceFactory.params(order_status: "paid")

      assert {:ok, %Order{} = inserted_order} = Orders.persist(insert_params)
      assert {:ok, %Order{} = updated_order} = Orders.persist(updated_params)

      assert inserted_order.id == updated_order.id
      assert updated_order.status == :paid
    end
  end
end
