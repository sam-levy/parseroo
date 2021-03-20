defmodule Parceroo.Factory do
  use ExMachina.Ecto, repo: Parceroo.Repo

  alias Parceroo.Orders.{Item, Order}

  def order_factory(attrs) do
    total_amount = Map.get(attrs, :total_amount, random_integer())
    total_shipping = Map.get(attrs, :total_shipping, random_integer(5..15))
    date_created = Map.get(attrs, :date_created, Faker.DateTime.backward(2))

    order = %Order{
      external_id: random_string_number(),
      store_id: random_integer(),
      date_created: date_created,
      date_closed: date_created,
      last_updated: date_created,
      total_amount: total_amount,
      total_shipping: total_shipping,
      total_amount_with_shipping: total_amount + total_shipping,
      paid_amount: total_amount + total_shipping,
      expiration_date: Faker.DateTime.forward(1)
    }

    merge_attributes(order, attrs)
  end

  def item_factory(attrs) do
    price = Map.get(attrs, :unit_price, random_integer(50..300))

    item = %Item{
      external_id: random_string_number(),
      title: Faker.Pokemon.name(),
      quantity: random_integer(1..3),
      unit_price: price,
      full_unit_price: price,
      order: build(:order, total_amount: price)
    }

    merge_attributes(item, attrs)
  end

  def random_integer(range \\ 10..9999), do: Enum.random(range)

  def random_string_number(range \\ 10..9999), do: range |> random_integer() |> to_string()
end
