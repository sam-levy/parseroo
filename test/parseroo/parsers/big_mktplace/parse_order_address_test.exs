defmodule Parseroo.Parsers.BigMktplace.ParseOrderAddressTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderAddress, Params.Order.Address}

  describe "call/1" do
    test "parses an order address" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderAddress.call(payload) == %Address{
               address_line: "Rua Fake de Testes 3454",
               city: "Cidade de Testes",
               complement: "teste",
               country_code: "BR",
               external_id: "1051695306",
               latitude: "-23.629037",
               longitude: "-46.712689",
               neighborhood: "Vila de Testes",
               receiver_phone: "41999999999",
               state: "SP",
               street_name: "Rua Fake de Testes",
               street_number: "3454",
               zip_code: "85045020"
             }
    end
  end
end
