defmodule Parseroo.Orders.Item do
  use Parseroo.Schema
  import Ecto.Changeset

  alias Money.Ecto.Amount.Type, as: MoneyType
  alias Parseroo.Orders.Order

  @fields [:external_id, :title, :quantity, :unit_price, :full_unit_price, :order_id]

  schema "order_items" do
    field :external_id, :string
    field :title, :string
    field :quantity, :integer
    field :unit_price, MoneyType
    field :full_unit_price, MoneyType

    belongs_to :order, Order

    timestamps()
  end

  def changeset(target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:external_id, max: 255)
    |> validate_length(:title, max: 255)
    |> validate_number(:quantity, greater_than: 0)
    |> check_constraint(:quantity, name: :order_items_quantity_greater_than_zero)
    |> unique_constraint(:external_id)
    |> assoc_constraint(:order)
  end
end
