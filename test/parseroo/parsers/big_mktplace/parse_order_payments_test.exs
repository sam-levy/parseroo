defmodule Parseroo.Parsers.BigMktplace.ParseOrderPaymentsTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderPayments, Params.Order.Payment}

  describe "call/1" do
    test "parses order payments" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderPayments.call(payload) == [
               %Payment{
                 date_approved: ~U[2019-06-24 20:45:35Z],
                 date_created: ~U[2019-06-24 20:45:33Z],
                 external_id: "12312313",
                 order_external_id: "9987071",
                 payer_external_id: "414138",
                 installment_amount: 5504,
                 installments: 1,
                 payment_type: "credit_card",
                 shipping_cost: 514,
                 status: "paid",
                 taxes_amount: 0,
                 total_paid_amount: 5504,
                 transaction_amount: 4990,
                 order_id: nil
               }
             ]
    end
  end
end
