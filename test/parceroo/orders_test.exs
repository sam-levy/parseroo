defmodule Parceroo.OrdersTest do
  use Parceroo.DataCase

  alias Parceroo.Orders

  describe "orders" do
    alias Parceroo.Orders.Order

    @valid_attrs %{date_closed: ~N[2010-04-17 14:00:00], date_created: ~N[2010-04-17 14:00:00], expiration_date: ~N[2010-04-17 14:00:00], external_id: "some external_id", last_updated: ~N[2010-04-17 14:00:00], paid_amount: 42, store_id: 42, total_amount: 42, total_amount_with_shipping: 42, total_shipping: 42}
    @update_attrs %{date_closed: ~N[2011-05-18 15:01:01], date_created: ~N[2011-05-18 15:01:01], expiration_date: ~N[2011-05-18 15:01:01], external_id: "some updated external_id", last_updated: ~N[2011-05-18 15:01:01], paid_amount: 43, store_id: 43, total_amount: 43, total_amount_with_shipping: 43, total_shipping: 43}
    @invalid_attrs %{date_closed: nil, date_created: nil, expiration_date: nil, external_id: nil, last_updated: nil, paid_amount: nil, store_id: nil, total_amount: nil, total_amount_with_shipping: nil, total_shipping: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Orders.create_order(@valid_attrs)
      assert order.date_closed == ~N[2010-04-17 14:00:00]
      assert order.date_created == ~N[2010-04-17 14:00:00]
      assert order.expiration_date == ~N[2010-04-17 14:00:00]
      assert order.external_id == "some external_id"
      assert order.last_updated == ~N[2010-04-17 14:00:00]
      assert order.paid_amount == 42
      assert order.store_id == 42
      assert order.total_amount == 42
      assert order.total_amount_with_shipping == 42
      assert order.total_shipping == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Orders.update_order(order, @update_attrs)
      assert order.date_closed == ~N[2011-05-18 15:01:01]
      assert order.date_created == ~N[2011-05-18 15:01:01]
      assert order.expiration_date == ~N[2011-05-18 15:01:01]
      assert order.external_id == "some updated external_id"
      assert order.last_updated == ~N[2011-05-18 15:01:01]
      assert order.paid_amount == 43
      assert order.store_id == 43
      assert order.total_amount == 43
      assert order.total_amount_with_shipping == 43
      assert order.total_shipping == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
