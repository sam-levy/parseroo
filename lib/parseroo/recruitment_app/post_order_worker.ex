defmodule Parseroo.RecruitmentApp.PostOrderWorker do
  use Oban.Worker, queue: :http_requests

  alias Parseroo.{Orders, RecruitmentApp}

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"order_id" => order_id}}) do
    with {:ok, order} <- Orders.fetch(order_id),
         {:ok, _} <- RecruitmentApp.post_order(order) do
      :ok
    else
      {:error, :not_found} -> {:discard, :not_found}
      {:error, reason} -> {:error, reason}
    end
  end
end
