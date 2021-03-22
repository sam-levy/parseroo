defmodule Parseroo.Orders.ItemTest do
  use Parseroo.DataCase, async: true

  alias Ecto.UUID
  alias Parseroo.Orders.Item
  alias Parseroo.Repo

  describe "changeset/2" do
    test "valid attributes" do
      price = random_integer(50..300)

      attrs = %{
        external_id: random_string_number(),
        title: Faker.Pokemon.name(),
        quantity: random_integer(1..3),
        unit_price: price,
        full_unit_price: price,
        order_id: UUID.generate()
      }

      assert %Ecto.Changeset{} = changeset = Item.changeset(attrs)

      assert changeset.valid?
      assert errors_on(changeset) == %{}
    end

    test "invalid attributes" do
      attrs = %{
        external_id: :invalid,
        title: :invalid,
        quantity: :invalid,
        unit_price: :invalid,
        full_unit_price: :invalid,
        order_id: :invalid
      }

      assert %Ecto.Changeset{} = changeset = Item.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               external_id: ["is invalid"],
               full_unit_price: ["is invalid"],
               order_id: ["is invalid"],
               quantity: ["is invalid"],
               title: ["is invalid"],
               unit_price: ["is invalid"]
             }
    end

    test "missing required attributes" do
      assert %Ecto.Changeset{} = changeset = Item.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               external_id: ["can't be blank"],
               full_unit_price: ["can't be blank"],
               order_id: ["can't be blank"],
               quantity: ["can't be blank"],
               title: ["can't be blank"],
               unit_price: ["can't be blank"]
             }
    end

    test "when string attributes are too long" do
      order = insert(:order)

      attrs =
        params_for(:item, %{
          external_id: 256 |> Faker.Lorem.characters() |> to_string(),
          title: 256 |> Faker.Lorem.characters() |> to_string(),
          order_id: order.id
        })

      assert %Ecto.Changeset{} = changeset = Item.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               external_id: ["should be at most 255 character(s)"],
               title: ["should be at most 255 character(s)"]
             }
    end

    test "when quantity is zero" do
      order = insert(:order)

      attrs = params_for(:item, %{quantity: 0, order_id: order.id})

      assert %Ecto.Changeset{} = changeset = Item.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{quantity: ["must be greater than 0"]}
    end

    test "when order does not exist" do
      attrs = params_for(:item, %{order_id: UUID.generate()})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Item.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{order: ["does not exist"]}
    end

    test "when external_id already exist" do
      order = insert(:order)
      external_id = random_string_number()

      insert(:item, external_id: external_id)

      attrs = params_for(:item, %{external_id: external_id, order_id: order.id})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Item.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{external_id: ["has already been taken"]}
    end
  end
end
