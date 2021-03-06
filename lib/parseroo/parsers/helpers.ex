defmodule Parseroo.Parsers.Helpers do
  def to_money_cents(value) do
    case Money.parse(value) do
      {:ok, %Money{amount: value}} -> value
      _ -> nil
    end
  end

  def money_to_float(%Money{} = money) do
    with string_value <- Money.to_string(money),
         float_value <- String.to_float(string_value) do
      float_value
    end
  end

  def to_utc_datetime(value) do
    with {:ok, utc_datetime, _} <- DateTime.from_iso8601(value),
         datetime <- DateTime.truncate(utc_datetime, :second) do
      datetime
    else
      _ -> nil
    end
  end
end
