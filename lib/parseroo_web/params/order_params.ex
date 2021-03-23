defmodule ParserooWeb.OrderParams do
  use ParserooWeb.Params

  @fields [
    :id,
    :store_id,
    :date_created,
    :date_closed,
    :last_updated,
    :total_amount,
    :total_shipping,
    :total_amount_with_shipping,
    :paid_amount,
    :expiration_date,
    :status
  ]

  @primary_key false
  embedded_schema do
    field :id, :integer
    field :store_id, :integer
    field :date_created, :string
    field :date_closed, :string
    field :last_updated, :string
    field :total_amount, :float
    field :total_shipping, :float
    field :total_amount_with_shipping, :float
    field :paid_amount, :float
    field :expiration_date, :string
    field :status, :string

    embeds_many :order_items, ParserooWeb.OrderItemParams
    embeds_many :payments, ParserooWeb.PaymentParams

    embeds_one :shipping, ParserooWeb.ShippingParams
    embeds_one :buyer, ParserooWeb.BuyerParams
  end

  def cast(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> cast_embed(:order_items)
    |> cast_embed(:payments)
    |> cast_embed(:shipping)
    |> cast_embed(:buyer)
    |> to_map()
  end
end
