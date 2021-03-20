defmodule Parceroo.Repo.Migrations.CreateOrderPayments do
  use Ecto.Migration
  import EctoEnumMigration

  def change do
    create_type(:order_payment_type, [:credit_card, :debit_card, :voucher, :boleto])
    create_type(:order_payment_status_type, [:pending, :paid, :rejected])

    create table(:order_payments) do
      add :external_id, :string, null: false
      add :order_external_id, :string, null: false
      add :payer_external_id, :string, null: false
      add :installments, :integer, null: false
      add :transaction_amount, :integer, null: false
      add :taxes_amount, :integer, null: false
      add :shipping_cost, :integer, null: false
      add :total_paid_amount, :integer, null: false
      add :installment_amount, :integer, null: false
      add :date_approved, :utc_datetime, null: false
      add :date_created, :utc_datetime, null: false

      add :payment_type, :order_payment_type, null: false
      add :status, :order_payment_status_type, null: false

      add :order_id, references(:orders), null: false

      timestamps()
    end

    create index(:order_payments, [:order_id])

    create unique_index(:order_payments, [:external_id])

    create constraint(:order_payments, :order_payments_installments_greater_than_zero,
             check: "installments > 0"
           )
  end
end
