defmodule DomeWeb.ThingView do
  use DomeWeb, :view
  alias DomeWeb.ThingView

  def render("index.json", %{things: things}) do
    %{data: render_many(things, ThingView, "thing.json")}
  end

  def render("show.json", %{thing: thing}) do
    %{data: render_one(thing, ThingView, "thing.json")}
  end

  def render("thing.json", %{thing: thing}) do

    {state, _} = case thing.type do
      "dimm" -> Integer.parse(thing.state)
      "temp" -> Integer.parse(thing.state)
      "hum" -> Integer.parse(thing.state)

      _ -> {thing.state, nil}
    end

    %{id: thing.id,
      name: thing.name,
      type: thing.type,
      state: state,
      chipid: thing.chipid}
  end
end
