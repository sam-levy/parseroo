defmodule Parseroo.Repo do
  use Ecto.Repo,
    otp_app: :parseroo,
    adapter: Ecto.Adapters.Postgres
end
