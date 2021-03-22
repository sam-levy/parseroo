defmodule Parseroo.Parsers.BigMktplace.ParseOrderShipmentTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderShipment, Params.Order.Shipment}

  describe "call/1" do
    test "parses an order shipment" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderShipment.call(payload) == %Shipment{
               date_created: "2019-06-24T16:45:33.000-04:00",
               external_id: "43444211797",
               shipment_type: "shipping",
               receiver_address_id: nil,
               order_id: nil
             }
    end
  end
end
