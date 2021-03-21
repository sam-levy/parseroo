defmodule Parseroo.Parsers.BigMktplace.ParseOrderPayments do
  alias Parseroo.Parsers.Params.Order.Payment

  def call(%{"payments" => payments}) do
    Enum.map(payments, &build_payment/1)
  end

  defp build_payment(payment) do
    %Payment{
      external_id: payment["id"],
      order_external_id: payment["order_external_id"],
      payer_external_id: payment["payer_external_id"],
      date_created: payment["date_created"],
      date_approved: payment["date_approved"],
      installments: payment["installments"],
      transaction_amount: payment["transaction_amount"],
      taxes_amount: payment["taxes_amount"],
      shipping_cost: payment["shipping_cost"],
      installment_amount: payment["installment_amount"],
      total_paid_amount: payment["total_paid_amount"],
      payment_type: payment["payment_type"],
      status: payment["status"],
      order_id: payment["order_id"]
    }
  end
end
