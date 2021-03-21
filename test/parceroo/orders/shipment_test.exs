defmodule Parceroo.Orders.ShipmentTest do
  use Parceroo.DataCase, async: true

  alias Ecto.UUID
  alias Parceroo.Orders.Shipment
  alias Parceroo.Repo

  describe "changeset/2" do
    test "valid attributes" do
      order = insert(:order)
      address = insert(:address)

      attrs = %{
        external_id: random_string_number(),
        date_created: Faker.DateTime.backward(2),
        shipment_type: "shipment",
        order_id: order.id,
        receiver_address_id: address.id
      }

      assert %Ecto.Changeset{} = changeset = Shipment.changeset(attrs)

      assert changeset.valid?
      assert errors_on(changeset) == %{}

      assert {:ok, %Shipment{}} =
               attrs
               |> Shipment.changeset()
               |> Repo.insert()
    end

    test "invalid attributes" do
      attrs = %{
        external_id: :invalid,
        date_created: :invalid,
        shipment_type: :invalid,
        order_id: :invalid,
        receiver_address_id: :invalid
      }

      assert %Ecto.Changeset{} = changeset = Shipment.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               date_created: ["is invalid"],
               external_id: ["is invalid"],
               order_id: ["is invalid"],
               receiver_address_id: ["is invalid"],
               shipment_type: ["is invalid"]
             }
    end

    test "missing required attributes" do
      assert %Ecto.Changeset{} = changeset = Shipment.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               date_created: ["can't be blank"],
               external_id: ["can't be blank"],
               order_id: ["can't be blank"],
               receiver_address_id: ["can't be blank"],
               shipment_type: ["can't be blank"]
             }
    end

    test "when string attributes are too long" do
      order = insert(:order)
      address = insert(:address)

      attrs =
        params_for(:shipment, %{
          external_id: 256 |> Faker.Lorem.characters() |> to_string(),
          shipment_type: 256 |> Faker.Lorem.characters() |> to_string(),
          order_id: order.id,
          receiver_address_id: address.id
        })

      assert %Ecto.Changeset{} = changeset = Shipment.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               shipment_type: ["should be at most 255 character(s)"],
               external_id: ["should be at most 255 character(s)"]
             }
    end

    test "when order does not exist" do
      address = insert(:address)

      attrs = params_for(:shipment, %{order_id: UUID.generate(), receiver_address_id: address.id})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Shipment.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{order: ["does not exist"]}
    end

    test "when receiver_address does not exist" do
      order = insert(:order)

      attrs = params_for(:shipment, %{order_id: order.id, receiver_address_id: UUID.generate()})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Shipment.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{receiver_address: ["does not exist"]}
    end

    test "when order_id already exist" do
      order = insert(:order)
      address = insert(:address)

      insert(:shipment, order: order)

      attrs = params_for(:shipment, %{order_id: order.id, receiver_address_id: address.id})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Shipment.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{order_id: ["has already been taken"]}
    end

    test "when external_id already exist" do
      order = insert(:order)
      address = insert(:address)

      external_id = random_string_number()

      insert(:shipment, external_id: external_id)

      attrs =
        params_for(:shipment, %{
          order_id: order.id,
          receiver_address_id: address.id,
          external_id: external_id
        })

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Shipment.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{external_id: ["has already been taken"]}
    end
  end
end
