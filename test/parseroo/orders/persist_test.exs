defmodule Parseroo.Orders.PersisTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.Orders
  alias Parseroo.Orders.Order
  alias Parseroo.BigMktPlaceFactory

  describe "call/1" do
    test "persists all schemas from order params" do
      order_params = BigMktPlaceFactory.params()

      {:ok, %Order{}} = Orders.persist(order_params)
    end
  end
end
