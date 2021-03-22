defmodule Parseroo.Orders do
  alias Parseroo.Orders.Persist

  defdelegate persist(payload), to: Persist, as: :call
end
