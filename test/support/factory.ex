defmodule Parseroo.Factory do
  use ExMachina.Ecto, repo: Parseroo.Repo

  alias Parseroo.Orders.{Address, Buyer, Item, Order, Payment, Shipment}

  def buyer_factory do
    %Buyer{
      external_id: random_string_number(),
      email: Faker.Internet.email(),
      phone_number: Faker.Phone.EnUs.phone(),
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      doc_type: "CPF",
      doc_number: "09487965477"
    }
  end

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
      expiration_date: Faker.DateTime.forward(1),
      status: :paid,
      buyer: build(:buyer)
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

  def address_factory do
    street_name = Faker.Address.PtBr.street_name()
    street_number = random_integer() |> to_string()

    %Address{
      external_id: random_string_number(),
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
  end

  def shipment_factory do
    %Shipment{
      external_id: random_string_number(),
      date_created: Faker.DateTime.backward(2),
      shipment_type: "shipment",
      order: build(:order),
      receiver_address: build(:address)
    }
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
