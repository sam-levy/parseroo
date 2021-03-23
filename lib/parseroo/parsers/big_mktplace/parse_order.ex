defmodule Parseroo.Parsers.BigMktplace.ParseOrder do
  import Parseroo.Parsers.Helpers

  alias Parseroo.Parsers.Params.Order

  def call(payload) do
    %Order{
      external_id: payload[:id] |> to_string(),
      store_id: payload[:store_id],
      date_created: payload[:date_created] |> to_utc_datetime(),
      date_closed: payload[:date_closed] |> to_utc_datetime(),
      last_updated: payload[:last_updated] |> to_utc_datetime(),
      total_amount: payload[:total_amount] |> to_money_cents(),
      total_shipping: payload[:total_shipping] |> to_money_cents(),
      total_amount_with_shipping: payload[:total_amount_with_shipping] |> to_money_cents(),
      paid_amount: payload[:paid_amount] |> to_money_cents(),
      expiration_date: payload[:expiration_date] |> to_utc_datetime(),
      status: payload[:status]
    }
  end
end
