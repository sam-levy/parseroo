defmodule Parseroo.Parsers.Params.OrderParams do
  defstruct order: nil,
            buyer: nil,
            shipment: nil,
            address: nil,
            items: [],
            payments: []
end
