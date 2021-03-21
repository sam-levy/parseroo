defmodule Parseroo.Parsers.BigMktplace.ParseOrderTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrder, Params.Order}

  describe "call/1" do
    test "parses an order" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrder.call(payload) == %Order{
               buyer_id: nil,
               date_closed: "2019-06-24T16:45:35.000-04:00",
               date_created: "2019-06-24T16:45:32.000-04:00",
               expiration_date: "2019-07-22T16:45:35.000-04:00",
               external_id: 9_987_071,
               last_updated: "2019-06-25T13:26:49.000-04:00",
               paid_amount: 55.04,
               status: "paid",
               store_id: 282,
               total_amount: 49.9,
               total_amount_with_shipping: 55.04,
               total_shipping: 5.14
             }
    end
  end
end
