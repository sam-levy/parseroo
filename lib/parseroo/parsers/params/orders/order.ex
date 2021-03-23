defmodule Parseroo.Parsers.Params.Orders.Order do
  @type t() :: %__MODULE__{
          external_id: String.t(),
          store_id: integer(),
          date_created: String.t(),
          date_closed: String.t(),
          last_updated: String.t(),
          total_amount: integer(),
          total_shipping: integer(),
          total_amount_with_shipping: integer(),
          paid_amount: integer(),
          expiration_date: String.t(),
          status: String.t(),
          buyer_id: nil | String.t()
        }

  defstruct [
    :external_id,
    :store_id,
    :date_created,
    :date_closed,
    :last_updated,
    :total_amount,
    :total_shipping,
    :total_amount_with_shipping,
    :paid_amount,
    :expiration_date,
    :status,
    :buyer_id
  ]
end
