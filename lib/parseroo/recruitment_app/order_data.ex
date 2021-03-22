defmodule Parseroo.RecruitmentApp.OrderData do
  import Parseroo.Parsers.Helpers, only: [money_to_float: 1]

  alias Parseroo.Orders.Order

  defstruct external_code: nil,
            store_id: nil,
            sub_total: nil,
            delivery_fee: nil,
            total: nil,
            country: nil,
            state: nil,
            city: nil,
            district: nil,
            street: nil,
            complement: nil,
            latitude: nil,
            longitude: nil,
            dt_order_create: nil,
            postal_code: nil,
            number: nil,
            customer: nil,
            items: [],
            payments: []

  defmodule Customer do
    defstruct external_code: nil,
              name: nil,
              email: nil,
              contact: nil
  end

  defmodule Item do
    defstruct external_code: nil,
              name: nil,
              price: nil,
              quantity: nil,
              total: nil,
              sub_items: []
  end

  defmodule Payment do
    defstruct type: nil,
              value: nil
  end

  def build(%Order{} = order) do
    %__MODULE__{}
    |> build_body(order)
    |> build_customer(order)
    |> build_items(order)
    |> build_payments(order)
  end

  def to_params(order_data) when is_struct(order_data) do
    order_data
    |> Map.from_struct()
    |> Enum.reject(fn {_, v} -> is_nil(v) end)
    |> Map.new(fn {k, v} -> {k, to_params(v)} end)
    |> Casex.to_camel_case()
  end

  def to_params(values) when is_list(values), do: Enum.map(values, &to_params/1)
  def to_params(value), do: value

  defp build_body(order_data, order) do
    %{
      order_data
      | external_code: order.external_id,
        store_id: order.store_id,
        sub_total: order.total_amount |> money_to_float(),
        delivery_fee: order.total_shipping |> money_to_float(),
        total: order.total_amount_with_shipping |> money_to_float(),
        country: order.shipment.receiver_address.country_code,
        state: order.shipment.receiver_address.state |> to_string(),
        city: order.shipment.receiver_address.city,
        district: order.shipment.receiver_address.neighborhood,
        street: order.shipment.receiver_address.street_name,
        complement: order.shipment.receiver_address.complement,
        latitude: order.shipment.receiver_address.latitude |> String.to_float(),
        longitude: order.shipment.receiver_address.longitude |> String.to_float(),
        dt_order_create: order.date_created |> DateTime.to_string(),
        postal_code: order.shipment.receiver_address.zip_code,
        number: order.shipment.receiver_address.street_number
    }
  end

  defp build_customer(order_data, %{buyer: buyer}) do
    customer = %Customer{
      external_code: buyer.external_id,
      name: "#{buyer.first_name} #{buyer.last_name}",
      email: buyer.email,
      contact: buyer.phone_number
    }

    %{order_data | customer: customer}
  end

  defp build_items(order_data, %{items: items}) do
    %{order_data | items: Enum.map(items, &build_item/1)}
  end

  defp build_item(item) do
    %Item{
      external_code: item.external_id,
      name: item.title,
      price: item.unit_price |> money_to_float(),
      quantity: item.quantity,
      total: item.full_unit_price |> money_to_float()
    }
  end

  defp build_payments(order_data, %{payments: payments}) do
    %{order_data | payments: Enum.map(payments, &build_payment/1)}
  end

  defp build_payment(payment) do
    %Payment{
      type: payment.payment_type |> to_string(),
      value: payment.total_paid_amount |> money_to_float()
    }
  end
end
