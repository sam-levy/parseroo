defmodule Parceroo.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:order_addresses) do
      add :external_id, :integer, null: false
      add :address_line, :string, null: false
      add :street_name, :string, null: false
      add :street_number, :string, null: false
      add :complement, :string, null: false
      add :zip_code, :string, null: false
      add :city, :string, null: false
      add :country_code, :string, null: false
      add :neighborhood, :string, null: false
      add :latitude, :string, null: false
      add :longitude, :string, null: false
      add :receiver_phone, :string, null: false

      add :state, :state_type, null: false

      timestamps()
    end

    create unique_index(:order_addresses, [:external_id])
  end
end
