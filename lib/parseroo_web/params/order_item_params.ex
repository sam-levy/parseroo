defmodule ParserooWeb.OrderItemParams do
  use ParserooWeb.Params

  @fields [
    :quantity,
    :unit_price,
    :full_unit_price
  ]

  @primary_key false
  embedded_schema do
    field :quantity, :integer
    field :unit_price, :float
    field :full_unit_price, :float

    embeds_one :item, ParserooWeb.ItemParams
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> cast_embed(:item)
  end
end

defmodule ParserooWeb.ItemParams do
  use ParserooWeb.Params

  @fields [:id, :title]

  @primary_key false
  embedded_schema do
    field :id, :string
    field :title, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
