defmodule Parseroo.RecruitmentApp.HTTPAdapterTest do
  use ExUnit.Case, async: true

  import Tesla.Mock

  alias Parseroo.Orders.Order
  alias Parseroo.RecruitmentApp.{HTTPAdapter, LocalAdapter}

  # TODO:
  describe "post_order/1" do
    # test "posts an order" do
    #   {:ok, body} = LocalAdapter.post_order(%Order{})

    #   mock(fn
    #     %{method: :post, url: url} ->
    #       assert url == "https://delivery-center-recruitment-ap.herokuapp.com/"

    #       %Tesla.Env{status: 200, body: body}
    #   end)

    #   assert HTTPAdapter.post_order(%Order{}) == {:ok, body}
    # end
  end
end
