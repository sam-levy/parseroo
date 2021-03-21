defmodule Parseroo.Parsers.BigMktplace do
  alias Parseroo.Parsers.Params.OrderParams

  alias Parseroo.Parsers.BigMktplace.{
    ParseOrder,
    ParseOrderAddress,
    ParseOrderBuyer,
    ParseOrderItems,
    ParseOrderPayments,
    ParseOrderShipment
  }

  def parse(payload) do
    %OrderParams{}
    |> parse_order(payload)
    |> parse_buyer(payload)
    |> parse_shipment(payload)
    |> parse_address(payload)
    |> parse_items(payload)
    |> parse_payments(payload)
  end

  defp parse_order(order_params, payload) do
    %{order_params | order: ParseOrder.call(payload)}
  end

  defp parse_buyer(order_params, payload) do
    %{order_params | buyer: ParseOrderBuyer.call(payload)}
  end

  defp parse_shipment(order_params, payload) do
    %{order_params | shipment: ParseOrderShipment.call(payload)}
  end

  defp parse_address(order_params, payload) do
    %{order_params | address: ParseOrderAddress.call(payload)}
  end

  defp parse_items(order_params, payload) do
    %{order_params | items: ParseOrderItems.call(payload)}
  end

  defp parse_payments(order_params, payload) do
    %{order_params | payments: ParseOrderPayments.call(payload)}
  end
end
