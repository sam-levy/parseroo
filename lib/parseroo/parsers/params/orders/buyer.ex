defmodule Parseroo.Parsers.Params.Orders.Buyer do
  defstruct [
    :external_id,
    :email,
    :phone_number,
    :first_name,
    :last_name,
    :doc_type,
    :doc_number,
    :nickname
  ]

  @type t() :: %__MODULE__{
          external_id: String.t(),
          email: String.t(),
          phone_number: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          doc_type: String.t(),
          doc_number: String.t(),
          nickname: String.t()
        }
end
