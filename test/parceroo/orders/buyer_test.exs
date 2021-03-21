defmodule Parceroo.Orders.BuyerTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.Orders.Buyer
  alias Parceroo.Repo

  describe "changeset/2" do
    test "valid attributes" do
      attrs = %{
        external_id: random_string_number(),
        email: Faker.Internet.email(),
        phone_number: Faker.Phone.EnUs.phone(),
        first_name: Faker.Person.first_name(),
        last_name: Faker.Person.last_name(),
        doc_type: "CPF",
        doc_number: "09487965477"
      }

      assert %Ecto.Changeset{} = changeset = Buyer.changeset(attrs)

      assert changeset.valid?
      assert errors_on(changeset) == %{}
    end

    test "invalid attributes" do
      attrs = %{
        external_id: :invalid,
        email: :invalid,
        phone_number: :invalid,
        first_name: :invalid,
        last_name: :invalid,
        doc_type: :invalid,
        doc_number: :invalid
      }

      assert %Ecto.Changeset{} = changeset = Buyer.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               doc_number: ["is invalid"],
               doc_type: ["is invalid"],
               email: ["is invalid"],
               external_id: ["is invalid"],
               first_name: ["is invalid"],
               last_name: ["is invalid"],
               phone_number: ["is invalid"]
             }
    end

    test "missing required attributes" do
      assert %Ecto.Changeset{} = changeset = Buyer.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               doc_number: ["can't be blank"],
               doc_type: ["can't be blank"],
               email: ["can't be blank"],
               external_id: ["can't be blank"],
               first_name: ["can't be blank"],
               last_name: ["can't be blank"],
               phone_number: ["can't be blank"]
             }
    end

    test "when string attributes are too long" do
      attrs = %{
        external_id: 256 |> Faker.Lorem.characters() |> to_string(),
        email: 256 |> Faker.Lorem.characters() |> to_string(),
        phone_number: 256 |> Faker.Lorem.characters() |> to_string(),
        first_name: 256 |> Faker.Lorem.characters() |> to_string(),
        last_name: 256 |> Faker.Lorem.characters() |> to_string(),
        doc_type: 256 |> Faker.Lorem.characters() |> to_string(),
        doc_number: 256 |> Faker.Lorem.characters() |> to_string()
      }

      assert %Ecto.Changeset{} = changeset = Buyer.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               doc_number: ["should be at most 255 character(s)"],
               doc_type: ["should be at most 255 character(s)"],
               email: ["has invalid format", "should be at most 255 character(s)"],
               external_id: ["should be at most 255 character(s)"],
               first_name: ["should be at most 255 character(s)"],
               last_name: ["should be at most 255 character(s)"],
               phone_number: ["should be at most 255 character(s)"]
             }
    end

    test "when external_id already exist" do
      external_id = random_string_number()

      insert(:buyer, external_id: external_id)

      attrs = params_for(:buyer, %{external_id: external_id})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Buyer.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{external_id: ["has already been taken"]}
    end
  end
end
