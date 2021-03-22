defmodule Parseroo.RecruitmentApp do
  @behaviour Parseroo.RecruitmentApp.Adapter

  alias Parseroo.Orders.Order
  alias Parseroo.RecruitmentApp.HTTPAdapter

  @impl true
  def post_order(%Order{} = order), do: HTTPAdapter.post_order(order)
end
