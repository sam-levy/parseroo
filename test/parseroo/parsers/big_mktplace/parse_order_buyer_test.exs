defmodule Parseroo.Parsers.BigMktplace.ParseOrderBuyerTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderBuyer, Params.Orders.Buyer}

  describe "call/1" do
    test "parses an order buyer" do
      payload = BigMktPlaceFactory.casted_payload()

      assert ParseOrderBuyer.call(payload) == %Buyer{
               doc_number: "09487965477",
               doc_type: "CPF",
               email: "john@doe.com",
               external_id: "136226073",
               first_name: "John",
               last_name: "Doe",
               nickname: "JOHN DOE",
               phone_number: "41999999999"
             }
    end
  end
end
