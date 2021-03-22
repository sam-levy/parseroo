defmodule Parseroo.RecruitmentApp.HTTPAdapter do
  @behaviour Parseroo.RecruitmentApp.Adapter

  alias Tesla.Env
  alias Parseroo.RecruitmentApp.OrderData

  @impl true
  def post_order(%OrderData{} = order_data) do
    client()
    |> Tesla.post("/", OrderData.to_params(order_data))
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
  defp handle_response(err), do: err

  defp client do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "https://delivery-center-recruitment-ap.herokuapp.com"},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middlewares)
  end
end
