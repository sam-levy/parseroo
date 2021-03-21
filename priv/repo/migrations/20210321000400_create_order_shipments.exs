defmodule Parceroo.Repo.Migrations.CreateOrderShipments do
  use Ecto.Migration
  import EctoEnumMigration

  def change do
    create table(:order_shipments) do
      add :external_id, :string, null: false
      add :date_created, :utc_datetime, null: false
      add :shipment_type, :string, null: false

      add :order_id, references(:orders), null: false
      add :receiver_address_id, references(:order_addresses), null: false

      timestamps()
    end

    create unique_index(:order_shipments, [:external_id])
    create unique_index(:order_shipments, [:order_id])
  end
end
