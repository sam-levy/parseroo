defmodule Parseroo.Orders.Buyer do
  use Parseroo.Schema
  import Ecto.Changeset

  @required_fields [
    :external_id,
    :email,
    :phone_number,
    :first_name,
    :last_name,
    :doc_type,
    :doc_number
  ]

  @optional_fields [:nickname]
  @fields @optional_fields ++ @required_fields

  schema "order_buyers" do
    field :external_id, :string
    field :doc_number, :string
    field :doc_type, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :nickname, :string
    field :phone_number, :string

    timestamps()
  end

  def changeset(target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_length(:external_id, max: 255)
    |> validate_length(:email, max: 255)
    |> validate_length(:phone_number, max: 255)
    |> validate_length(:first_name, max: 255)
    |> validate_length(:last_name, max: 255)
    |> validate_length(:doc_type, max: 255)
    |> validate_length(:doc_number, max: 255)
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint(:external_id)
  end
end
