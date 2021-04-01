defmodule Parseroo.Parsers.Params.Orders.Item do
  @required_fields [:external_id, :title, :quantity, :unit_price, :full_unit_price]
  @optional_fields [:order_id]

  @fields @required_fields ++ @optional_fields

  @enforce_keys @required_fields
  defstruct @fields

  @type t() :: %__MODULE__{
          external_id: String.t(),
          title: String.t(),
          quantity: String.t(),
          unit_price: String.t(),
          full_unit_price: String.t(),
          order_id: nil | String.t()
        }
end
