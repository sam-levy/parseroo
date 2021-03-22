defmodule Parseroo.Parsers.Helpers do
  def float_to_money_cents(value) when is_float(value) do
    case Money.new(value) do
      {:ok, %Money{amount: value}} -> value
      _ -> nil
    end
  end
end
