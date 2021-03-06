defmodule Parseroo.Orders.Shipment do
  use Parseroo.Schema
  import Ecto.Changeset

  alias Parseroo.Orders.{Address, Order}

  @fields [:external_id, :date_created, :shipment_type, :order_id, :receiver_address_id]

  schema "order_shipments" do
    field :external_id, :string
    field :date_created, :utc_datetime
    field :shipment_type, :string

    belongs_to :order, Order
    belongs_to :receiver_address, Address

    timestamps()
  end

  def changeset(target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:external_id, max: 255)
    |> validate_length(:shipment_type, max: 255)
    |> unique_constraint(:external_id)
    |> unique_constraint(:order_id)
    |> assoc_constraint(:order)
    |> assoc_constraint(:receiver_address)
  end
end
