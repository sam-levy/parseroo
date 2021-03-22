defmodule Parseroo.RecruitmentApp.Adapter do
  alias Parseroo.RecruitmentApp.OrderData

  @callback post_order(opts :: OrderData.t()) :: {:ok, map()} | {:error, any()}
end
