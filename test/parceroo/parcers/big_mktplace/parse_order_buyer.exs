defmodule Parseroo.Parsers.BigMktplace.ParseOrderBuyerTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderBuyer, Params.Order.Buyer}

  describe "call/1" do
    test "parses an order buyer" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderBuyer.call(payload) == %Buyer{
               doc_number: "09487965477",
               doc_type: "CPF",
               email: "john@doe.com",
               external_id: 136_226_073,
               first_name: "John",
               last_name: "Doe",
               nickname: "JOHN DOE",
               phone_number: "41999999999"
             }
    end
  end
end
