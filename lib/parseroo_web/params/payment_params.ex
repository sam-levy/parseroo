defmodule ParserooWeb.PaymentParams do
  use ParserooWeb.Params

  @fields [
    :id,
    :order_id,
    :payer_id,
    :installments,
    :payment_type,
    :status,
    :transaction_amount,
    :taxes_amount,
    :shipping_cost,
    :total_paid_amount,
    :installment_amount,
    :date_approved,
    :date_created
  ]

  @primary_key false
  embedded_schema do
    field :id, :integer
    field :order_id, :integer
    field :payer_id, :integer
    field :installments, :integer
    field :payment_type, :string
    field :status, :string
    field :transaction_amount, :float
    field :taxes_amount, :float
    field :shipping_cost, :float
    field :total_paid_amount, :float
    field :installment_amount, :float
    field :date_approved, :string
    field :date_created, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
