defmodule DomeWeb.ThingControllerTest do
  use DomeWeb.ConnCase

  alias Dome.IOT
  alias Dome.IOT.Thing

  @create_attrs %{
    name: "some name",
    state: "some state",
    type: "some type"
  }
  @update_attrs %{
    name: "some updated name",
    state: "some updated state",
    type: "some updated type"
  }
  @invalid_attrs %{name: nil, state: nil, type: nil}

  def fixture(:thing) do
    {:ok, thing} = IOT.create_thing(@create_attrs)
    thing
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all things", %{conn: conn} do
      conn = get(conn, Routes.thing_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create thing" do
    test "renders thing when data is valid", %{conn: conn} do
      conn = post(conn, Routes.thing_path(conn, :create), thing: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.thing_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "state" => "some state",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.thing_path(conn, :create), thing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update thing" do
    setup [:create_thing]

    test "renders thing when data is valid", %{conn: conn, thing: %Thing{id: id} = thing} do
      conn = put(conn, Routes.thing_path(conn, :update, thing), thing: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.thing_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "state" => "some updated state",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, thing: thing} do
      conn = put(conn, Routes.thing_path(conn, :update, thing), thing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete thing" do
    setup [:create_thing]

    test "deletes chosen thing", %{conn: conn, thing: thing} do
      conn = delete(conn, Routes.thing_path(conn, :delete, thing))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.thing_path(conn, :show, thing))
      end
    end
  end

  defp create_thing(_) do
    thing = fixture(:thing)
    {:ok, thing: thing}
  end
end
