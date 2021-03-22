defmodule Parseroo.Orders do
  alias Parseroo.Orders.{Fetch, Persist}

  defdelegate persist(payload), to: Persist, as: :call
  defdelegate fetch(id), to: Fetch, as: :call
end
