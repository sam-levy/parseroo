defmodule Parseroo.Parsers.BigMktplace.ParseOrderPaymentsTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderPayments, Params.Order.Payment}

  describe "call/1" do
    test "parses order payments" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderPayments.call(payload) == [
               %Payment{
                 date_approved: "2019-06-24T16:45:35.000-04:00",
                 date_created: "2019-06-24T16:45:33.000-04:00",
                 external_id: "12312313",
                 order_external_id: "9987071",
                 payer_external_id: "414138",
                 installment_amount: 55.04,
                 installments: 1,
                 payment_type: "credit_card",
                 shipping_cost: 5.14,
                 status: "paid",
                 taxes_amount: 0,
                 total_paid_amount: 55.04,
                 transaction_amount: 49.9,
                 order_id: nil
               }
             ]
    end
  end
end
