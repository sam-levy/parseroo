defmodule Parseroo.Parsers.BigMktplace.ParseOrder do
  alias Parseroo.Parsers.Params.Order

  def call(payload) do
    %Order{
      external_id: payload["id"],
      store_id: payload["store_id"],
      date_created: payload["date_created"],
      date_closed: payload["date_closed"],
      last_updated: payload["last_updated"],
      total_amount: payload["total_amount"],
      total_shipping: payload["total_shipping"],
      total_amount_with_shipping: payload["total_amount_with_shipping"],
      paid_amount: payload["paid_amount"],
      expiration_date: payload["expiration_date"],
      status: payload["status"]
    }
  end
end
