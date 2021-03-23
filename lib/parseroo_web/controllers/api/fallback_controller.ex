defmodule ParserooWeb.Api.FallbackController do
  @moduledoc false
  use Phoenix.Controller

  alias Ecto.Changeset
  alias ParserooWeb.ErrorView

  def call(conn, {:error, changeset = %Changeset{valid?: false}}) do
    errors = Changeset.traverse_errors(changeset, &reduce_error/1)

    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("errors.json", errors: errors)
  end

  defp reduce_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
