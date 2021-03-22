defmodule Parseroo.Parsers.BigMktplace.ParseOrderPayments do
  import Parseroo.Parsers.Helpers, only: [float_to_money_cents: 1]

  alias Parseroo.Parsers.Params.Order.Payment

  def call(%{"payments" => payments}) do
    Enum.map(payments, &build_payment/1)
  end

  defp build_payment(payment) do
    %Payment{
      external_id: to_string(payment["id"]),
      order_external_id: to_string(payment["order_id"]),
      payer_external_id: to_string(payment["payer_id"]),
      date_created: payment["date_created"],
      date_approved: payment["date_approved"],
      installments: payment["installments"],
      transaction_amount: payment["transaction_amount"] |> float_to_money_cents(),
      taxes_amount: payment["taxes_amount"] |> float_to_money_cents(),
      shipping_cost: payment["shipping_cost"] |> float_to_money_cents(),
      installment_amount: payment["installment_amount"] |> float_to_money_cents(),
      total_paid_amount: payment["total_paid_amount"],
      payment_type: payment["payment_type"],
      status: payment["status"]
    }
  end
end
