defmodule ParserooWeb.API.BigMktplace.V1.OrderControllerTest do
  use ParserooWeb.ConnCase, async: true

  alias Parseroo.{BigMktPlaceFactory, Repo}
  alias Parseroo.Orders.Order

  describe "POST /api/big_mktplace/v1/orders [create]" do
    test "creates an order", %{conn: conn} do
      path = Routes.big_mktplace_v1_order_path(conn, :create)
      payload = BigMktPlaceFactory.payload()

      assert %{"orderId" => order_id} =
               conn
               |> post(path, payload)
               |> json_response(:created)

      assert Repo.get(Order, order_id)
    end
  end
end
