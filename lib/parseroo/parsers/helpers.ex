defmodule Parseroo.Parsers.Helpers do
  def to_money_cents(value) do
    case Money.parse(value) do
      {:ok, %Money{amount: value}} -> value
      _ -> nil
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
