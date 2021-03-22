defmodule Parseroo.Parsers.Params.Order do
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
