defmodule Parseroo.Parsers.BigMktplace.ParseOrderItems do
  alias Parseroo.Parsers.Params.Order.Item

  def call(%{"order_items" => items}) do
    Enum.map(items, &build_item/1)
  end

  defp build_item(item) do
    %Item{
      external_id: item["item"]["id"],
      title: item["item"]["title"],
      quantity: item["quantity"],
      unit_price: item["unit_price"],
      full_unit_price: item["full_unit_price"]
    }
  end
end
