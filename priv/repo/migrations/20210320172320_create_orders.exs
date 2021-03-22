defmodule Parseroo.Repo.Migrations.CreateOrders do
  use Ecto.Migration
  import EctoEnumMigration

  def change do
    create_type(:order_status_type, [:paid, :in_transit, :delivered])

    create table(:orders) do
      add :external_id, :string, null: false
      add :store_id, :integer, null: false
      add :date_created, :utc_datetime, null: false
      add :date_closed, :utc_datetime, null: false
      add :last_updated, :utc_datetime, null: false
      add :total_amount, :integer, null: false
      add :total_shipping, :integer, null: false
      add :total_amount_with_shipping, :integer, null: false
      add :paid_amount, :integer, null: false
      add :expiration_date, :utc_datetime, null: false

      add :status, :order_status_type, null: false

      add :buyer_id, references(:order_buyers), null: false

      timestamps()
    end

    create index(:orders, [:buyer_id])

    create unique_index(:orders, [:external_id])
  end
end
