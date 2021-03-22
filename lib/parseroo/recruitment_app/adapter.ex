defmodule Parseroo.RecruitmentApp.Adapter do
  alias Parseroo.Orders.Order

  @callback post_order(order :: Order.t()) :: {:ok, map()} | {:error, any()}
end
