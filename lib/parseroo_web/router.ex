defmodule ParserooWeb.Router do
  use ParserooWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ParserooWeb do
    pipe_through :api
  end
end
