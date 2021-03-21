defmodule Parceroo.Orders.Address do
  use Parceroo.Schema
  import Ecto.Changeset

  alias Parceroo.StateType

  @fields [
    :external_id,
    :address_line,
    :street_name,
    :street_number,
    :complement,
    :zip_code,
    :city,
    :country_code,
    :neighborhood,
    :latitude,
    :longitude,
    :receiver_phone,
    :state
  ]

  schema "order_addresses" do
    field :external_id, :string
    field :address_line, :string
    field :street_name, :string
    field :street_number, :string
    field :complement, :string
    field :zip_code, :string
    field :city, :string
    field :country_code, :string
    field :neighborhood, :string
    field :latitude, :string
    field :longitude, :string
    field :receiver_phone, :string
    field :state, StateType

    timestamps()
  end

  def changeset(target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:external_id, max: 255)
    |> validate_length(:address_line, max: 255)
    |> validate_length(:street_name, max: 255)
    |> validate_length(:street_number, max: 255)
    |> validate_length(:complement, max: 255)
    |> validate_length(:zip_code, max: 255)
    |> validate_length(:city, max: 255)
    |> validate_length(:country_code, max: 2)
    |> validate_length(:neighborhood, max: 255)
    |> validate_length(:latitude, max: 255)
    |> validate_length(:longitude, max: 255)
    |> validate_length(:receiver_phone, max: 255)
    |> unique_constraint(:external_id)
  end
end
