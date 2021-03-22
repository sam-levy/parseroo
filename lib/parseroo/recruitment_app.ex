defmodule Parseroo.RecruitmentApp do
  @behaviour Parseroo.RecruitmentApp.Adapter

  alias Parseroo.RecruitmentApp.{HTTPAdapter, OrderData}

  @impl true
  def post_order(%OrderData{} = order_data), do: HTTPAdapter.post_order(order_data)
end
