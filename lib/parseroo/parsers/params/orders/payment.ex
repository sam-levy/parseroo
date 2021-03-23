defmodule Parseroo.Parsers.Params.Orders.Payment do
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

  @type t() :: %__MODULE__{
          external_id: String.t(),
          order_external_id: String.t(),
          payer_external_id: String.t(),
          date_created: DateTime.t(),
          date_approved: DateTime.t(),
          installments: integer(),
          transaction_amount: integer(),
          taxes_amount: integer(),
          shipping_cost: integer(),
          installment_amount: integer(),
          total_paid_amount: integer(),
          payment_type: integer(),
          status: String.t(),
          order_id: nil | String.t()
        }
end
