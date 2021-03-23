defmodule ParserooWeb.ShippingParams do
  use ParserooWeb.Params

  alias ParserooWeb.ReceiverAddressParams

  @fields [
    :id,
    :shipment_type,
    :date_created
  ]

  @primary_key false
  embedded_schema do
    field :id, :integer
    field :shipment_type, :string
    field :date_created, :string

    embeds_one :receiver_address, ReceiverAddressParams
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> cast_embed(:receiver_address)
  end
end
