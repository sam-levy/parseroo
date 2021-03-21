defmodule Parceroo.OrderTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.Orders.Order

  describe "changeset/2" do
    test "valid attributes" do
      date_created = Faker.DateTime.backward(2)
      total_amount = random_integer()
      total_shipping = random_integer(5..15)

      attrs = %{
        external_id: random_string_number(),
        store_id: random_integer(),
        date_created: date_created,
        date_closed: date_created,
        last_updated: date_created,
        total_amount: total_amount,
        total_shipping: total_shipping,
        total_amount_with_shipping: total_amount + total_shipping,
        paid_amount: total_amount + total_shipping,
        expiration_date: Faker.DateTime.forward(1),
        status: :paid
      }

      assert %Ecto.Changeset{} = changeset = Order.changeset(attrs)

      assert changeset.valid?
      assert errors_on(changeset) == %{}
    end

    test "invalid attributes" do
      attrs = %{
        external_id: :invalid,
        store_id: :invalid,
        date_created: :invalid,
        date_closed: :invalid,
        last_updated: :invalid,
        total_amount: :invalid,
        total_shipping: :invalid,
        total_amount_with_shipping: :invalid,
        paid_amount: :invalid,
        expiration_date: :invalid,
        status: :invalid
      }

      assert %Ecto.Changeset{} = changeset = Order.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               date_closed: ["is invalid"],
               date_created: ["is invalid"],
               external_id: ["is invalid"],
               last_updated: ["is invalid"],
               paid_amount: ["is invalid"],
               store_id: ["is invalid"],
               total_amount: ["is invalid"],
               total_amount_with_shipping: ["is invalid"],
               total_shipping: ["is invalid"],
               expiration_date: ["is invalid"],
               status: ["is invalid"]
             }
    end

    test "missing required attributes" do
      assert %Ecto.Changeset{} = changeset = Order.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               date_closed: ["can't be blank"],
               date_created: ["can't be blank"],
               expiration_date: ["can't be blank"],
               external_id: ["can't be blank"],
               last_updated: ["can't be blank"],
               paid_amount: ["can't be blank"],
               store_id: ["can't be blank"],
               total_amount: ["can't be blank"],
               total_amount_with_shipping: ["can't be blank"],
               total_shipping: ["can't be blank"],
               status: ["can't be blank"]
             }
    end

    test "when string attributes are too long" do
      attrs = params_for(:order, %{external_id: 256 |> Faker.Lorem.characters() |> to_string()})

      assert %Ecto.Changeset{} = changeset = Order.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{external_id: ["should be at most 255 character(s)"]}
    end

    test "when external_id already exist" do
      external_id = random_string_number()

      insert(:order, external_id: external_id)

      attrs = params_for(:order, %{external_id: external_id})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Order.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{external_id: ["has already been taken"]}
    end
  end
end
