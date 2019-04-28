defmodule Dome.IOT.ThingHandler do
  use Tortoise.Handler

  def init(args) do
    {:ok, args}
  end

  def connection(status, state) do
    # `status` will be either `:up` or `:down`; you can use this to
    # inform the rest of your system if the connection is currently
    # open or closed; tortoise should be busy reconnecting if you get
    # a `:down`
    {:ok, state}
  end

  def handle_message(["server", chipid], payload, state) do
    thing = Dome.IOT.get_thing_by_chipid!(chipid)

    {:ok, thing} = Dome.IOT.update_thing(thing, %{state: payload})

    response = DomeWeb.ThingView.render("show.json", %{thing: thing})

    DomeWeb.Endpoint.broadcast("room:lobby", "ITEM_UPDATED", response.data)

    {:ok, state}
  end

  def handle_message(topic, payload, state) do
    # unhandled message! You will crash if you subscribe to something
    # and you don't have a 'catch all' matcher; crashing on unexpected
    # messages could be a strategy though.
    {:ok, state}
  end

  def subscription(status, topic_filter, state) do
    {:ok, state}
  end

  def terminate(reason, state) do
    # tortoise doesn't care about what you return from terminate/2,
    # that is in alignment with other behaviours that implement a
    # terminate-callback
    :ok
  end
end
