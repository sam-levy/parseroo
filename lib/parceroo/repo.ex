defmodule Parceroo.Repo do
  use Ecto.Repo,
    otp_app: :parceroo,
    adapter: Ecto.Adapters.Postgres
end
