defmodule Parseroo.Parsers.BigMktplace.ParseOrderItems do
  import Parseroo.Parsers.Helpers, only: [to_money_cents: 1]

  alias Parseroo.Parsers.Params.Orders.Item

  def call(%{order_items: items}) do
    Enum.map(items, &build_item/1)
  end

  defp build_item(item) do
    %Item{
      external_id: item.item.id |> to_string(),
      title: item.item.title,
      quantity: item.quantity,
      unit_price: item.unit_price |> to_money_cents(),
      full_unit_price: item.full_unit_price |> to_money_cents()
    }
  end
end
