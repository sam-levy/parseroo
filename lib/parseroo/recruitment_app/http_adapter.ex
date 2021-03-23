defmodule Parseroo.RecruitmentApp.HTTPAdapter do
  @behaviour Parseroo.RecruitmentApp.Adapter

  alias Parseroo.Orders.Order
  alias Parseroo.RecruitmentApp.OrderData
  alias Tesla.Env

  @impl true
  def post_order(%Order{} = order) do
    order_params =
      order
      |> OrderData.build()
      |> OrderData.to_params()

    client()
    |> Tesla.post("/orders", order_params)
    |> handle_response()
  end

  defp handle_response({:ok, %Env{status: 200, body: body}}) when is_map(body), do: {:ok, body}
  defp handle_response({:ok, %Env{status: 200, body: body}}), do: {:ok, %{"data" => body}}
  defp handle_response({:ok, %Env{status: 201, body: body}}) when is_map(body), do: {:ok, body}
  defp handle_response({:ok, %Env{status: 201, body: body}}), do: {:ok, %{"data" => body}}
  defp handle_response({:ok, %Env{status: 204}}), do: {:ok, %{}}
  defp handle_response({:ok, %Env{status: 404}}), do: {:ok, :not_found}
  defp handle_response({:ok, %Env{status: 400}}), do: {:error, :bad_request}
  defp handle_response({:ok, %Env{status: 403}}), do: {:error, :access_denied}
  defp handle_response({:ok, unexpected_response}), do: {:error, unexpected_response}

  defp client do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "https://delivery-center-recruitment-ap.herokuapp.com"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"x-sent", build_datetime()}]}
    ]

    Tesla.client(middlewares)
  end

  defp build_datetime do
    Calendar.strftime(DateTime.utc_now(), "%Hh%M - %d/%m/%y")
  end
end
