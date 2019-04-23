defmodule Dome.IOTTest do
  use Dome.DataCase

  alias Dome.IOT

  describe "things" do
    alias Dome.IOT.Thing

    @valid_attrs %{name: "light", state: "on", type: "switch", chipid: "1234"}
    @update_attrs %{name: "light updated", state: "off", type: "sensor"}
    @invalid_attrs %{name: nil, state: nil, type: nil, chipid: nil}

    def thing_fixture(attrs \\ %{}) do
      {:ok, thing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> IOT.create_thing()

      thing
    end

    test "list_things/0 returns all things" do
      thing = thing_fixture()
      assert IOT.list_things() == [thing]
    end

    test "get_thing!/1 returns the thing with given id" do
      thing = thing_fixture()
      assert IOT.get_thing!(thing.id) == thing
    end

    test "create_thing/1 with valid data creates a thing" do
      assert {:ok, %Thing{} = thing} = IOT.create_thing(@valid_attrs)
      assert thing.name == "light"
      assert thing.state == "on"
      assert thing.type == "switch"
    end

    test "create_thing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = IOT.create_thing(@invalid_attrs)
    end

    test "update_thing/2 with valid data updates the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{} = thing} = IOT.update_thing(thing, @update_attrs)
      assert thing.name == "light updated"
      assert thing.state == "off"
      assert thing.type == "sensor"
    end

    test "update_thing/2 with invalid data returns error changeset" do
      thing = thing_fixture()
      assert {:error, %Ecto.Changeset{}} = IOT.update_thing(thing, @invalid_attrs)
      assert thing == IOT.get_thing!(thing.id)
    end

    test "delete_thing/1 deletes the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{}} = IOT.delete_thing(thing)
      assert_raise Ecto.NoResultsError, fn -> IOT.get_thing!(thing.id) end
    end

    test "change_thing/1 returns a thing changeset" do
      thing = thing_fixture()
      assert %Ecto.Changeset{} = IOT.change_thing(thing)
    end
  end
end
