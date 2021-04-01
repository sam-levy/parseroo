defmodule Parseroo.Parsers.Params.Orders.Payment do
  @required_fields [
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
    :status
  ]

  @optional_fields [:order_id]

  @fields @required_fields ++ @optional_fields

  @enforce_keys @required_fields
  defstruct @fields

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
