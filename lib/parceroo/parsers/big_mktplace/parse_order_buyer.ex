defmodule Parseroo.Parsers.BigMktplace.ParseOrderBuyer do
  alias Parseroo.Parsers.Params.Order.Buyer

  def call(%{"buyer" => buyer}) do
    %Buyer{
      external_id: buyer["id"],
      email: buyer["email"],
      phone_number: phone_number(buyer["phone"]),
      first_name: buyer["first_name"],
      last_name: buyer["last_name"],
      doc_type: buyer["billing_info"]["doc_type"],
      doc_number: buyer["billing_info"]["doc_number"],
      nickname: buyer["nickname"]
    }
  end

  defp phone_number(%{"area_code" => code, "number" => number}), do: "#{code}#{number}"
end
