defmodule DomeWeb.ThingController do
  use DomeWeb, :controller

  alias Dome.IOT
  alias Dome.IOT.Thing

  action_fallback DomeWeb.FallbackController

  def index(conn, _params) do
    things = IOT.list_things()
    render(conn, "index.json", things: things)
  end

  def create(conn, %{"thing" => thing_params}) do
    with {:ok, %Thing{} = thing} <- IOT.create_thing(thing_params) do
      Tortoise.Connection.subscribe("dome", {"server/#{thing.chipid}", 0})

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.thing_path(conn, :show, thing))
      |> render("show.json", thing: thing)
    end
  end

  def show(conn, %{"id" => id}) do
    thing = IOT.get_thing!(id)
    render(conn, "show.json", thing: thing)
  end

  def update(conn, %{"id" => id, "thing" => thing_params}) do
    thing = IOT.get_thing!(id)

    with {:ok, %Thing{} = thing} <- IOT.update_thing(thing, thing_params) do
      Tortoise.publish("dome", "dev/#{thing.chipid}", thing.state)
      render(conn, "show.json", thing: thing)
    end
  end

  def delete(conn, %{"id" => id}) do
    thing = IOT.get_thing!(id)

    with {:ok, %Thing{}} <- IOT.delete_thing(thing) do
      send_resp(conn, :no_content, "")
    end
  end
end
