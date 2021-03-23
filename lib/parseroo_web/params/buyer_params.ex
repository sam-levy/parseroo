defmodule ParserooWeb.BuyerParams do
  use ParserooWeb.Params

  @fields [
    :id,
    :nickname,
    :email,
    :first_name,
    :last_name
  ]

  @primary_key false
  embedded_schema do
    field :id, :integer
    field :nickname, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string

    embeds_one :phone, ParserooWeb.PhoneParams
    embeds_one :billing_info, ParserooWeb.BillingInfoParams
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> cast_embed(:phone)
    |> cast_embed(:billing_info)
  end
end

defmodule ParserooWeb.PhoneParams do
  use ParserooWeb.Params

  @fields [:area_code, :number]

  @primary_key false
  embedded_schema do
    field :area_code, :integer
    field :number, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end

defmodule ParserooWeb.BillingInfoParams do
  use ParserooWeb.Params

  @fields [:doc_type, :doc_number]

  @primary_key false
  embedded_schema do
    field :doc_type, :string
    field :doc_number, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
