defmodule ParcerooWeb.Router do
  use ParcerooWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ParcerooWeb do
    pipe_through :api
  end
end
