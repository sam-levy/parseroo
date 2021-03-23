defmodule Parseroo.Parsers.Params.Orders.Address do
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

  @type t() :: %__MODULE__{
          external_id: String.t(),
          address_line: String.t(),
          street_name: String.t(),
          street_number: String.t(),
          complement: String.t(),
          zip_code: String.t(),
          city: String.t(),
          country_code: String.t(),
          neighborhood: String.t(),
          latitude: String.t(),
          longitude: String.t(),
          receiver_phone: String.t(),
          state: String.t()
        }
end
