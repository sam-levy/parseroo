defmodule Parseroo.Parsers.Params.Order.Address do
  defstruct [
    :external_id,
    :address_line,
    :street_name,
    :street_number,
    :complement,
    :zip_code,
    :city,
    :country_code,
    :neighborhood,
    :latitude,
    :longitude,
    :receiver_phone,
    :state
  ]
end
