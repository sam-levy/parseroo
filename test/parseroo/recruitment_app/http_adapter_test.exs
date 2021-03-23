defmodule Parseroo.RecruitmentApp.HTTPAdapterTest do
  use Parseroo.DataCase, async: true

  import Tesla.Mock

  alias Parseroo.Orders.Order
  alias Parseroo.RecruitmentApp.{HTTPAdapter, LocalAdapter}

  describe "post_order/1" do
    #   test "posts an order" do
    #     buyer = insert(:buyer)
    #     order = insert(:order, buyer: buyer)
    #     address = insert(:address)

    #     insert(:item, order: order)
    #     insert(:payment, order: order)
    #     insert(:shipment, order: order, receiver_address: address)

    #     order = Repo.preload(order, [:items, :payments, :buyer, shipment: [:receiver_address]])

    #     {:ok, body} = LocalAdapter.post_order(%Order{})

    #     mock(fn
    #       %{method: :post, url: url} ->
    #         assert url == "https://delivery-center-recruitment-ap.herokuapp.com/orders"

    #         %Tesla.Env{status: 200, body: body}
    #     end)

    #     assert HTTPAdapter.post_order(order) == {:ok, body}
    #   end
  end
end
