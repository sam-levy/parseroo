defmodule Parseroo.Parsers.Params.Orders.Item do
  defstruct [:external_id, :title, :quantity, :unit_price, :full_unit_price, :order_id]

  @type t() :: %__MODULE__{
          external_id: String.t(),
          title: String.t(),
          quantity: String.t(),
          unit_price: String.t(),
          full_unit_price: String.t(),
          order_id: nil | String.t()
        }
end
