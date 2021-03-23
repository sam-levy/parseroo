defmodule Parseroo.Parsers.BigMktplace.ParseOrderAddress do
  alias Parseroo.Geo
  alias Parseroo.Parsers.Params.Orders.Address

  def call(%{shipping: %{receiver_address: address}}) do
    %Address{
      external_id: address[:id] |> to_string(),
      address_line: address[:address_line],
      street_name: address[:street_name],
      street_number: address[:street_number],
      complement: address[:comment],
      zip_code: address[:zip_code],
      city: address[:city][:name],
      state: address[:state][:name] |> Geo.get_uf_from_name() |> to_string(),
      country_code: address[:country][:id],
      neighborhood: address[:neighborhood][:name],
      latitude: address[:latitude] |> Float.to_string(),
      longitude: address[:longitude] |> Float.to_string(),
      receiver_phone: address[:receiver_phone]
    }
  end
end
