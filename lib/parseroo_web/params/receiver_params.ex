defmodule ParserooWeb.ReceiverAddressParams do
  use ParserooWeb.Params

  @fields [
    :id,
    :address_line,
    :street_name,
    :street_number,
    :comment,
    :zip_code,
    :latitude,
    :longitude,
    :receiver_phone
  ]

  @primary_key false
  embedded_schema do
    field :id, :integer
    field :address_line, :string
    field :street_name, :string
    field :street_number, :string
    field :comment, :string
    field :zip_code, :string
    field :latitude, :float
    field :longitude, :float
    field :receiver_phone, :string

    embeds_one :city, ParserooWeb.CityParams
    embeds_one :state, ParserooWeb.StateParams
    embeds_one :country, ParserooWeb.CountryParams
    embeds_one :neighborhood, ParserooWeb.NeighborhoodParams
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> cast_embed(:city)
    |> cast_embed(:state)
    |> cast_embed(:country)
    |> cast_embed(:neighborhood)
  end
end

defmodule ParserooWeb.CityParams do
  use ParserooWeb.Params

  @fields [:name]

  @primary_key false
  embedded_schema do
    field :name, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end

defmodule ParserooWeb.StateParams do
  use ParserooWeb.Params

  @fields [:name]

  @primary_key false
  embedded_schema do
    field :name, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end

defmodule ParserooWeb.CountryParams do
  use ParserooWeb.Params

  @fields [:id, :name]

  @primary_key false
  embedded_schema do
    field :id, :string
    field :name, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end

defmodule ParserooWeb.NeighborhoodParams do
  use ParserooWeb.Params

  @fields [:id, :name]

  @primary_key false
  embedded_schema do
    field :id, :string
    field :name, :string
  end

  def changeset(target, params) do
    target
    |> cast(params, @fields)
    |> validate_required([:name])
  end
end
