defmodule ParserooWeb.API.BigMktplace.V1.OrderController do
  use ParserooWeb, :controller

  alias Parseroo.Orders
  alias Parseroo.Parsers.BigMktplace
  alias Parseroo.RecruitmentApp

  # def create(conn, params) do
  #   with {:ok, order} <- params |> BigMktplace.parse() |> Orders.persist(),
  #        {:ok, order} <- Orders.fetch(order.id),
  #        {:ok, _} <- RecruitmentApp.post_order(order) do
  #     conn
  #     |> put_status(:created)
  #     |> json(%{status: "created"})
  #   end
  # end

  def create(conn, params) do
    with {:ok, order} <- params |> BigMktplace.parse() |> Orders.persist() do
      conn
      |> put_status(:created)
      |> json(%{orderId: order.id})
    end
  end
end
