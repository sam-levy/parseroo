defmodule Parseroo.Repo.Migrations.CreateOrderBuyers do
  use Ecto.Migration

  def change do
    create table(:order_buyers) do
      add :external_id, :string, null: false
      add :nickname, :string
      add :email, :string, null: false
      add :phone_number, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :doc_type, :string, null: false
      add :doc_number, :string, null: false

      timestamps()
    end

    create unique_index(:order_buyers, [:external_id])
  end
end
