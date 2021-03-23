defmodule ParserooWeb.ParamsTest do
  use Parseroo.DataCase, async: true

  alias ParserooWeb.Params

  defmodule DummyParams do
    use ParserooWeb.Params

    defmodule DummyEmbedded do
      use ParserooWeb.Params

      @fields [:id, :field]

      embedded_schema do
        field :field, :string
      end

      def changeset(dummy, params), do: cast(dummy, params, @fields)
    end

    @fields [:id, :string_field, :map_field, :list_field]

    embedded_schema do
      field :string_field, :string
      field :map_field, :map
      field :list_field, {:array, :integer}

      embeds_many :dummies, DummyEmbedded
      embeds_one :dummy, DummyEmbedded
    end

    def changeset(params) do
      %__MODULE__{}
      |> cast(params, @fields)
      |> validate_required([:string_field])
      |> cast_embed(:dummies)
      |> cast_embed(:dummy)
    end
  end

  describe "to_map/1" do
    test "returns a map when the changeset is valid" do
      params = %{
        "id" => "some_id",
        "string_field" => "some string",
        "map_field" => %{"key" => "value"},
        "list_field" => [1, 2, 3],
        "dummies" => [
          %{"field" => "value"},
          %{"field" => "other value"}
        ],
        "dummy" => %{"field" => "value"}
      }

      assert {:ok, map} =
               params
               |> DummyParams.changeset()
               |> Params.to_map()

      assert map == %{
               dummies: [%{field: "value", id: nil}, %{field: "other value", id: nil}],
               dummy: %{field: "value", id: nil},
               id: "some_id",
               list_field: [1, 2, 3],
               map_field: %{"key" => "value"},
               string_field: "some string"
             }
    end

    test "returns the changeset when it is invalid" do
      assert {:error, changeset} =
               %{}
               |> DummyParams.changeset()
               |> Params.to_map()

      refute changeset.valid?
    end
  end

  describe "cast/2" do
    test "when field type is valid" do
      params = %{read: true}

      assert Params.cast(params, %{read: :boolean}) == {:ok, %{read: true}}
    end

    test "when field type is invalid" do
      params = %{read: "invalid value"}

      assert {:error, changeset} = Params.cast(params, %{read: :boolean})

      assert errors_on(changeset) == %{read: ["is invalid"]}
    end
  end
end
