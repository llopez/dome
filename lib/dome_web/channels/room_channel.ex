defmodule DomeWeb.RoomChannel do
  use Phoenix.Channel
  def join("room:lobby", _message, socket) do
    things = Dome.IOT.list_things()

    response = DomeWeb.ThingView.render("index.json", %{things: things})

    {:ok, response, socket}
  end

  def handle_in("delete:item", %{"id" => id} = attrs, socket) do
    thing = Dome.IOT.get_thing!(id)

    with {:ok, %Dome.IOT.Thing{}} <- Dome.IOT.delete_thing(thing) do
      broadcast!(socket, "ITEM_REMOVED", %{id: id})
    end

    {:noreply, socket}
  end

  def handle_in("update:item", %{"id" => id} = attrs, socket) do
    thing = Dome.IOT.get_thing!(id)

    with {:ok, %Dome.IOT.Thing{}} <- Dome.IOT.update_thing(thing, attrs) do
      broadcast!(socket, "ITEM_UPDATED", attrs)
    end

    {:noreply, socket}
  end
end
