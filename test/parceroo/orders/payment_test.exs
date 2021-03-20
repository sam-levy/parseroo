defmodule Parceroo.PaymentTest do
  use Parceroo.DataCase, async: true

  alias Ecto.UUID
  alias Parceroo.Orders.Payment
  alias Parceroo.Repo

  describe "changeset/2" do
    test "valid attributes" do
      order = insert(:order)

      attrs = %{
        external_id: random_string_number(),
        order_external_id: random_string_number(),
        payer_external_id: random_string_number(),
        date_created: Faker.DateTime.backward(2),
        date_approved: Faker.DateTime.backward(2),
        installments: random_integer(1..12),
        transaction_amount: random_integer(3000..10000),
        taxes_amount: random_integer(300..1000),
        shipping_cost: random_integer(300..1000),
        installment_amount: random_integer(3000..10000),
        total_paid_amount: random_integer(3000..10000),
        payment_type: :credit_card,
        status: :paid,
        order_id: order.id
      }

      assert %Ecto.Changeset{} = changeset = Payment.changeset(attrs)

      assert changeset.valid?
      assert errors_on(changeset) == %{}

      assert {:ok, %Payment{}} =
               attrs
               |> Payment.changeset()
               |> Repo.insert()
    end

    test "invalid attributes" do
      attrs = %{
        external_id: :invalid,
        order_external_id: :invalid,
        payer_external_id: :invalid,
        date_created: :invalid,
        date_approved: :invalid,
        installments: :invalid,
        transaction_amount: :invalid,
        taxes_amount: :invalid,
        shipping_cost: :invalid,
        installment_amount: :invalid,
        total_paid_amount: :invalid,
        payment_type: :invalid,
        status: :invalid,
        order_id: :invalid
      }

      assert %Ecto.Changeset{} = changeset = Payment.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               date_approved: ["is invalid"],
               date_created: ["is invalid"],
               external_id: ["is invalid"],
               installment_amount: ["is invalid"],
               installments: ["is invalid"],
               order_external_id: ["is invalid"],
               order_id: ["is invalid"],
               payer_external_id: ["is invalid"],
               payment_type: ["is invalid"],
               shipping_cost: ["is invalid"],
               status: ["is invalid"],
               taxes_amount: ["is invalid"],
               total_paid_amount: ["is invalid"],
               transaction_amount: ["is invalid"]
             }
    end

    test "missing required attributes" do
      assert %Ecto.Changeset{} = changeset = Payment.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               date_approved: ["can't be blank"],
               date_created: ["can't be blank"],
               external_id: ["can't be blank"],
               installment_amount: ["can't be blank"],
               installments: ["can't be blank"],
               order_external_id: ["can't be blank"],
               order_id: ["can't be blank"],
               payer_external_id: ["can't be blank"],
               payment_type: ["can't be blank"],
               shipping_cost: ["can't be blank"],
               status: ["can't be blank"],
               taxes_amount: ["can't be blank"],
               total_paid_amount: ["can't be blank"],
               transaction_amount: ["can't be blank"]
             }
    end

    test "when string attributes are too long" do
      order = insert(:order)

      attrs =
        params_for(:payment, %{
          external_id: 256 |> Faker.Lorem.characters() |> to_string(),
          order_external_id: 256 |> Faker.Lorem.characters() |> to_string(),
          payer_external_id: 256 |> Faker.Lorem.characters() |> to_string(),
          order_id: order.id
        })

      assert %Ecto.Changeset{} = changeset = Payment.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               external_id: ["should be at most 255 character(s)"],
               order_external_id: ["should be at most 255 character(s)"],
               payer_external_id: ["should be at most 255 character(s)"]
             }
    end

    test "when installments is zero" do
      order = insert(:order)

      attrs =
        params_for(:payment, %{
          installments: 0,
          order_id: order.id
        })

      assert %Ecto.Changeset{} = changeset = Payment.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{installments: ["must be greater than 0"]}
    end

    test "when order does not exist" do
      attrs = params_for(:payment, %{order_id: UUID.generate()})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Payment.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{order: ["does not exist"]}
    end

    test "when external_id already exist" do
      order = insert(:order)
      external_id = random_string_number()

      insert(:payment, external_id: external_id)

      attrs = params_for(:payment, %{order_id: order.id, external_id: external_id})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Payment.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{external_id: ["has already been taken"]}
    end
  end
end
