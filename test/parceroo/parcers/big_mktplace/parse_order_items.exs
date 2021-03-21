defmodule Parseroo.Parsers.BigMktplace.ParseOrderItemsTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderItems, Params.Order.Item}

  describe "call/1" do
    test "parses order items" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderItems.call(payload) == [
               %Item{
                 external_id: "IT4801901403",
                 full_unit_price: 49.9,
                 quantity: 1,
                 title: "Produto de Testes",
                 unit_price: 49.9
               }
             ]
    end
  end
end
