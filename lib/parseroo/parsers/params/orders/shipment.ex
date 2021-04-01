defmodule Parseroo.Parsers.Params.Orders.Shipment do
  @required_fields [:external_id, :date_created, :shipment_type]
  @optional_fields [:order_id, :receiver_address_id]

  @fields @required_fields ++ @optional_fields

  @enforce_keys @required_fields
  defstruct @fields

  @type t() :: %__MODULE__{
          external_id: String.t(),
          date_created: String.t(),
          shipment_type: String.t(),
          receiver_address_id: String.t(),
          order_id: nil | String.t()
        }
end
