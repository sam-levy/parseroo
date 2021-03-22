defmodule Parseroo.OrdersTest do
  use Parseroo.DataCase, async: true

  # alias Parseroo.Orders.Address
  alias Parseroo.Repo
  alias Parseroo.Orders

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.BigMktplace

  describe "persist/1" do
    test "persists all schemas from order params" do
      payload = BigMktPlaceFactory.payload()
      order_params = BigMktplace.parse(payload)

      IO.inspect(order_params)

      # {:ok, order} = Orders.persist(order_params)
      # IO.inspect(order)

      {:error, changeset} = Orders.persist(order_params)

      IO.inspect(changeset.errors)
    end
  end
end
