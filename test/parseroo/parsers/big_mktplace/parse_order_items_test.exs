defmodule Parseroo.Parsers.BigMktplace.ParseOrderItemsTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
  alias Parseroo.Parsers.{BigMktplace.ParseOrderItems, Params.Order.Item}

  describe "call/1" do
    test "parses order items" do
      payload = BigMktPlaceFactory.payload()

      assert ParseOrderItems.call(payload) == [
               %Item{
                 external_id: "IT4801901403",
                 full_unit_price: 4990,
                 quantity: 1,
                 title: "Produto de Testes",
                 unit_price: 4990,
                 order_id: nil
               }
             ]
    end
  end
end
