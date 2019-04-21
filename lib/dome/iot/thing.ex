defmodule Dome.IOT.Thing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "things" do
    field :name, :string
    field :state, :string
    field :type, :string
    field :chipid, :string

    timestamps()
  end

  @doc false
  def changeset(thing, attrs) do
    thing
    |> cast(attrs, [:name, :type, :state, :chipid])
    |> validate_required([:name, :type, :state, :chipid])
  end
end
