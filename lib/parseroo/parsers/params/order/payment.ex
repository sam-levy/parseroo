defmodule Parseroo.Parsers.Params.Order.Payment do
  defstruct [
    :external_id,
    :order_external_id,
    :payer_external_id,
    :date_created,
    :date_approved,
    :installments,
    :transaction_amount,
    :taxes_amount,
    :shipping_cost,
    :installment_amount,
    :total_paid_amount,
    :payment_type,
    :status,
    :order_id
  ]
end
