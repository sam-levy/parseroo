defmodule Parceroo.Orders.Order do
  use Parceroo.Schema
  import Ecto.Changeset

  alias Money.Ecto.Amount.Type, as: MoneyType
  alias Parceroo.Orders.Buyer

  defenum(OrderStatusType, :order_status_type, [:paid, :in_transit, :delivered])

  @fields [
    :external_id,
    :store_id,
    :date_created,
    :date_closed,
    :last_updated,
    :total_amount,
    :total_shipping,
    :total_amount_with_shipping,
    :paid_amount,
    :expiration_date,
    :status,
    :buyer_id
  ]

  schema "orders" do
    field :external_id, :string
    field :store_id, :integer
    field :date_created, :utc_datetime
    field :date_closed, :utc_datetime
    field :last_updated, :utc_datetime
    field :total_amount, MoneyType
    field :total_shipping, MoneyType
    field :total_amount_with_shipping, MoneyType
    field :paid_amount, MoneyType
    field :status, OrderStatusType
    field :expiration_date, :utc_datetime

    belongs_to :buyer, Buyer

    timestamps()
  end

  def changeset(target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:external_id, max: 255)
    |> unique_constraint(:external_id)
    |> assoc_constraint(:buyer)
  end
end
