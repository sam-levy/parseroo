defmodule Parseroo.Parsers.BigMktplace.ParseOrderPaymentsTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderPayments, Params.Order.Payment}

  describe "call/1" do
    test "parses order payments" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderPayments.call(payload) == [
               %Payment{
                 date_approved: "2019-06-24T16:45:35.000-04:00",
                 date_created: "2019-06-24T16:45:33.000-04:00",
                 external_id: 12_312_313,
                 installment_amount: 55.04,
                 installments: 1,
                 order_external_id: nil,
                 order_id: 9_987_071,
                 payer_external_id: nil,
                 payment_type: "credit_card",
                 shipping_cost: 5.14,
                 status: "paid",
                 taxes_amount: 0,
                 total_paid_amount: 55.04,
                 transaction_amount: 49.9
               }
             ]
    end
  end
end
