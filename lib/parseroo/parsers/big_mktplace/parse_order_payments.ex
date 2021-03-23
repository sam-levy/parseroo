defmodule Parseroo.Parsers.BigMktplace.ParseOrderPayments do
  import Parseroo.Parsers.Helpers

  alias Parseroo.Parsers.Params.Orders.Payment

  def call(%{payments: payments}) do
    Enum.map(payments, &build_payment/1)
  end

  defp build_payment(payment) do
    %Payment{
      external_id: payment[:id] |> to_string(),
      order_external_id: payment[:order_id] |> to_string(),
      payer_external_id: payment[:payer_id] |> to_string(),
      date_created: payment[:date_created] |> to_utc_datetime(),
      date_approved: payment[:date_approved] |> to_utc_datetime(),
      installments: payment[:installments],
      transaction_amount: payment[:transaction_amount] |> to_money_cents(),
      taxes_amount: payment[:taxes_amount] |> to_money_cents(),
      shipping_cost: payment[:shipping_cost] |> to_money_cents(),
      installment_amount: payment[:installment_amount] |> to_money_cents(),
      total_paid_amount: payment[:total_paid_amount] |> to_money_cents(),
      payment_type: payment[:payment_type],
      status: payment[:status]
    }
  end
end
