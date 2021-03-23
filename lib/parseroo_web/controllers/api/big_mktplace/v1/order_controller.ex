defmodule ParserooWeb.API.BigMktplace.V1.OrderController do
  use ParserooWeb, :controller

  alias Parseroo.Orders
  alias Parseroo.Parsers.BigMktplace
  alias Parseroo.RecruitmentApp.PostOrderWorker

  alias ParserooWeb.OrderParams

  def create(conn, params) do
    with {:ok, order_params} <- OrderParams.cast(params),
         {:ok, order} <- order_params |> BigMktplace.parse() |> Orders.persist(),
         {:ok, _job} <- %{"order_id" => order.id} |> PostOrderWorker.new() |> Oban.insert() do
      conn
      |> put_status(:created)
      |> json(%{status: "created"})
    end
  end
end
