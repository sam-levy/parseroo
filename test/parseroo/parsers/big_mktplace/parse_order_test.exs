defmodule Parseroo.Parsers.BigMktplace.ParseOrderTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrder, Params.Order}

  describe "call/1" do
    test "parses an order" do
      payload = BigMktPlaceFactory.casted_payload()

      assert ParseOrder.call(payload) == %Order{
               buyer_id: nil,
               date_closed: ~U[2019-06-24 20:45:35Z],
               date_created: ~U[2019-06-24 20:45:32Z],
               expiration_date: ~U[2019-07-22 20:45:35Z],
               external_id: "9987071",
               last_updated: ~U[2019-06-25 17:26:49Z],
               paid_amount: 5504,
               status: "paid",
               store_id: 282,
               total_amount: 4990,
               total_amount_with_shipping: 5504,
               total_shipping: 514
             }
    end
  end
end
