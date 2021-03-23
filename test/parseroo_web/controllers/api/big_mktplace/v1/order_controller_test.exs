defmodule ParserooWeb.API.BigMktplace.V1.OrderControllerTest do
  use ParserooWeb.ConnCase, async: true

  alias Parseroo.{BigMktPlaceFactory, Repo}
  alias Parseroo.Orders.Order
  alias Parseroo.RecruitmentApp.PostOrderWorker

  describe "POST /api/big_mktplace/v1/orders [create]" do
    test "creates an order", %{conn: conn} do
      path = Routes.big_mktplace_v1_order_path(conn, :create)
      payload = BigMktPlaceFactory.payload()

      assert %{"status" => "created"} =
               conn
               |> post(path, payload)
               |> json_response(:created)

      assert Order |> Repo.all() |> Enum.count() == 1

      assert Enum.count(all_enqueued(worker: PostOrderWorker)) == 1
    end

    test "when payload is invalid", %{conn: conn} do
      path = Routes.big_mktplace_v1_order_path(conn, :create)
      payload = %{"payload" => "invalid"}

      assert %{"errors" => errors} =
               conn
               |> post(path, payload)
               |> json_response(:unprocessable_entity)

      assert errors == %{
               "date_closed" => ["can't be blank"],
               "date_created" => ["can't be blank"],
               "expiration_date" => ["can't be blank"],
               "id" => ["can't be blank"],
               "last_updated" => ["can't be blank"],
               "paid_amount" => ["can't be blank"],
               "status" => ["can't be blank"],
               "store_id" => ["can't be blank"],
               "total_amount" => ["can't be blank"],
               "total_amount_with_shipping" => ["can't be blank"],
               "total_shipping" => ["can't be blank"]
             }
    end
  end
end
