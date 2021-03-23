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
    %OrderParams{
      order: ParseOrder.call(payload),
      buyer: ParseOrderBuyer.call(payload),
      shipment: ParseOrderShipment.call(payload),
      address: ParseOrderAddress.call(payload),
      items: ParseOrderItems.call(payload),
      payments: ParseOrderPayments.call(payload)
    }
  end
end
