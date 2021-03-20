defmodule Parceroo.Factory do
  use ExMachina.Ecto, repo: Parceroo.Repo

  alias Parceroo.Orders.{Item, Order, Payment}

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

  def payment_factory(attrs) do
    date_created = Map.get(attrs, :date_created, Faker.DateTime.backward(2))
    transaction_amount = Map.get(attrs, :transaction_amount, random_integer(3000..10000))
    taxes_amount = Map.get(attrs, :taxes_amount, round(transaction_amount * 0.20))
    shipping_cost = Map.get(attrs, :shipping_cost, round(transaction_amount * 0.10))
    installments = Map.get(attrs, :installments, random_integer(1..12))

    total_paid_amount =
      Map.get(attrs, :total_paid_amount, transaction_amount + taxes_amount + shipping_cost)

    installment_amount =
      Map.get(attrs, :installment_amount, division_or_dividend(total_paid_amount, installments))

    payment = %Payment{
      external_id: random_string_number(),
      order_external_id: random_string_number(),
      payer_external_id: random_string_number(),
      date_created: date_created,
      date_approved: date_created,
      installments: installments,
      transaction_amount: transaction_amount,
      taxes_amount: taxes_amount,
      shipping_cost: shipping_cost,
      installment_amount: installment_amount,
      total_paid_amount: total_paid_amount,
      payment_type: random_enum_value(Payment.PaymentType),
      status: :paid,
      order: build(:order, total_shipping: shipping_cost, total_amount: total_paid_amount)
    }

    merge_attributes(payment, attrs)
  end

  def random_integer(range \\ 10..9999), do: Enum.random(range)

  def random_string_number(range \\ 10..9999), do: range |> random_integer() |> to_string()

  defp random_enum_value(enum) do
    enum.__valid_values__()
    |> Enum.filter(&is_binary/1)
    |> Enum.random()
  end

  defp division_or_dividend(dividend, 0), do: dividend
  defp division_or_dividend(dividend, nil), do: dividend
  defp division_or_dividend(dividend, divisor), do: round(dividend / divisor)
end
