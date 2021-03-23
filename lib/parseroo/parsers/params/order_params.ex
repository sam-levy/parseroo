defmodule Parseroo.Parsers.Params.OrderParams do
  alias Parseroo.Parsers.Params.Orders.{
    Buyer,
    Order,
    Shipment,
    Address,
    Item,
    Payment
  }

  defstruct [:order, :buyer, :shipment, :address, :items, :payments]

  @type t() :: %__MODULE__{
          order: Order.t(),
          buyer: Buyer.t(),
          shipment: Shipment.t(),
          address: Address.t(),
          items: list(Item.t()),
          payments: list(Payment.t())
        }
end
