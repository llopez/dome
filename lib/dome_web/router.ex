defmodule DomeWeb.Router do
  use DomeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DomeWeb do
    pipe_through :api
    resources "/things", ThingController, except: [:new, :edit]
  end
end
