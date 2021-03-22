defmodule Parseroo.Parsers.BigMktplace.ParseOrderShipment do
  alias Parseroo.Parsers.Params.Order.Shipment

  def call(%{"shipping" => shipping}) do
    %Shipment{
      external_id: to_string(shipping["id"]),
      date_created: shipping["date_created"],
      shipment_type: shipping["shipment_type"]
    }
  end
end
