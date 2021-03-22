defmodule Parseroo.Orders.Payment do
  use Parseroo.Schema

  import Ecto.Changeset

  alias Money.Ecto.Amount.Type, as: MoneyType
  alias Parseroo.Orders.Order

  defenum(PaymentType, :order_payment_type, [
    :credit_card,
    :debit_card,
    :voucher,
    :boleto
  ])

  defenum(PaymentStatusType, :order_payment_status_type, [
    :pending,
    :paid,
    :rejected
  ])

  @fields [
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

  schema "order_payments" do
    field :external_id, :string
    field :order_external_id, :string
    field :payer_external_id, :string
    field :date_created, :utc_datetime
    field :date_approved, :utc_datetime
    field :installments, :integer
    field :transaction_amount, MoneyType
    field :taxes_amount, MoneyType
    field :shipping_cost, MoneyType
    field :installment_amount, MoneyType
    field :total_paid_amount, MoneyType
    field :payment_type, PaymentType
    field :status, PaymentStatusType

    belongs_to :order, Order

    timestamps()
  end

  def changeset(target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:external_id, max: 255)
    |> validate_length(:order_external_id, max: 255)
    |> validate_length(:payer_external_id, max: 255)
    |> validate_number(:installments, greater_than: 0)
    |> check_constraint(:installments, name: :order_payments_installments_greater_than_zero)
    |> unique_constraint(:external_id)
    |> assoc_constraint(:order)
  end
end
