defmodule ParserooWeb.Router do
  use ParserooWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ParserooWeb.API do
    pipe_through :api

    scope "/big_mktplace/v1", BigMktplace.V1, as: :big_mktplace_v1 do
      resources "/orders", OrderController, only: [:create]
    end
  end
end
