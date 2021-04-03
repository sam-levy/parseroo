defmodule Parseroo.Parsers.BigMktplace.ParseOrderShipment do
  import Parseroo.Parsers.Helpers, only: [to_utc_datetime: 1]

  alias Parseroo.Parsers.Params.Orders.Shipment

  def call(%{shipping: shipping}) do
    %Shipment{
      external_id: shipping.id |> to_string(),
      date_created: shipping.date_created |> to_utc_datetime(),
      shipment_type: shipping.shipment_type
    }
  end
end
