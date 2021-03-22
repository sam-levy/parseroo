defmodule Parseroo.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :external_id, :string, null: false
      add :title, :string, null: false
      add :quantity, :integer, null: false
      add :unit_price, :integer, null: false
      add :full_unit_price, :integer, null: false

      add :order_id, references(:orders), null: false

      timestamps()
    end

    create index(:order_items, [:order_id])

    create unique_index(:order_items, [:external_id])

    create constraint(:order_items, :order_items_quantity_greater_than_zero, check: "quantity > 0")
  end
end
