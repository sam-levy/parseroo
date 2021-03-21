defmodule Parceroo.AddressTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.Orders.Address
  alias Parceroo.Repo

  describe "changeset/2" do
    test "valid attributes" do
      street_name = Faker.Address.PtBr.street_name()
      street_number = random_integer() |> to_string()

      attrs = %{
        external_id: random_integer(),
        address_line: "#{street_name} #{street_number}",
        street_name: street_name,
        street_number: street_number,
        complement: Faker.Lorem.sentence(3),
        zip_code: Faker.Address.PtBr.zip_code(),
        city: Faker.Address.PtBr.city(),
        country_code: "BR",
        neighborhood: Faker.Address.PtBr.neighborhood(),
        latitude: Faker.Address.latitude() |> Float.to_string(),
        longitude: Faker.Address.longitude() |> Float.to_string(),
        receiver_phone: Faker.Phone.EnUs.phone(),
        state: Faker.Address.PtBr.state_abbr()
      }

      assert %Ecto.Changeset{} = changeset = Address.changeset(attrs)

      assert changeset.valid?
      assert errors_on(changeset) == %{}

      assert {:ok, %Address{}} =
               attrs
               |> Address.changeset()
               |> Repo.insert()
    end

    test "invalid attributes" do
      attrs = %{
        external_id: :invalid,
        address_line: :invalid,
        street_name: :invalid,
        street_number: :invalid,
        complement: :invalid,
        zip_code: :invalid,
        city: :invalid,
        country_code: :invalid,
        neighborhood: :invalid,
        latitude: :invalid,
        longitude: :invalid,
        receiver_phone: :invalid,
        state: :invalid
      }

      assert %Ecto.Changeset{} = changeset = Address.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               address_line: ["is invalid"],
               city: ["is invalid"],
               complement: ["is invalid"],
               country_code: ["is invalid"],
               external_id: ["is invalid"],
               latitude: ["is invalid"],
               longitude: ["is invalid"],
               neighborhood: ["is invalid"],
               receiver_phone: ["is invalid"],
               state: ["is invalid"],
               street_name: ["is invalid"],
               street_number: ["is invalid"],
               zip_code: ["is invalid"]
             }
    end

    test "missing required attributes" do
      assert %Ecto.Changeset{} = changeset = Address.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               address_line: ["can't be blank"],
               city: ["can't be blank"],
               complement: ["can't be blank"],
               country_code: ["can't be blank"],
               external_id: ["can't be blank"],
               latitude: ["can't be blank"],
               longitude: ["can't be blank"],
               neighborhood: ["can't be blank"],
               receiver_phone: ["can't be blank"],
               state: ["can't be blank"],
               street_name: ["can't be blank"],
               street_number: ["can't be blank"],
               zip_code: ["can't be blank"]
             }
    end

    test "when string attributes are too long" do
      price = random_integer(50..300)

      attrs =
        params_for(:address, %{
          address_line: 256 |> Faker.Lorem.characters() |> to_string(),
          street_name: 256 |> Faker.Lorem.characters() |> to_string(),
          street_number: 256 |> Faker.Lorem.characters() |> to_string(),
          complement: 256 |> Faker.Lorem.characters() |> to_string(),
          zip_code: 256 |> Faker.Lorem.characters() |> to_string(),
          city: 256 |> Faker.Lorem.characters() |> to_string(),
          country_code: 256 |> Faker.Lorem.characters() |> to_string(),
          neighborhood: 256 |> Faker.Lorem.characters() |> to_string(),
          latitude: 256 |> Faker.Lorem.characters() |> to_string(),
          longitude: 256 |> Faker.Lorem.characters() |> to_string(),
          receiver_phone: 256 |> Faker.Lorem.characters() |> to_string()
        })

      assert %Ecto.Changeset{} = changeset = Address.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               address_line: ["should be at most 255 character(s)"],
               city: ["should be at most 255 character(s)"],
               complement: ["should be at most 255 character(s)"],
               country_code: ["should be at most 2 character(s)"],
               latitude: ["should be at most 255 character(s)"],
               longitude: ["should be at most 255 character(s)"],
               neighborhood: ["should be at most 255 character(s)"],
               receiver_phone: ["should be at most 255 character(s)"],
               street_name: ["should be at most 255 character(s)"],
               street_number: ["should be at most 255 character(s)"],
               zip_code: ["should be at most 255 character(s)"]
             }
    end

    test "when external_id already exist" do
      external_id = random_string_number()

      insert(:address, external_id: external_id)

      attrs = params_for(:address, %{external_id: external_id})

      assert {:error, %Ecto.Changeset{} = changeset} =
               attrs
               |> Address.changeset()
               |> Repo.insert()

      refute changeset.valid?

      assert errors_on(changeset) == %{external_id: ["has already been taken"]}
    end
  end
end
