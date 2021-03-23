defmodule Parseroo.Parsers.Params.Orders.Shipment do
  defstruct [:external_id, :date_created, :shipment_type, :order_id, :receiver_address_id]

  @type t() :: %__MODULE__{
          external_id: String.t(),
          date_created: String.t(),
          shipment_type: String.t(),
          receiver_address_id: String.t(),
          order_id: nil | String.t()
        }
end
