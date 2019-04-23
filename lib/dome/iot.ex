defmodule Dome.IOT do
  @moduledoc """
  The IOT context.
  """

  import Ecto.Query, warn: false
  alias Dome.Repo

  alias Dome.IOT.Thing

  @doc """
  Returns the list of things.

  ## Examples

      iex> list_things()
      [%Thing{}, ...]

  """
  def list_things do
    Repo.all(Thing)
  end

  @doc """
  Gets a single thing.

  Raises `Ecto.NoResultsError` if the Thing does not exist.

  ## Examples

      iex> get_thing!(123)
      %Thing{}

      iex> get_thing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thing!(id), do: Repo.get!(Thing, id)

  @doc """
  Gets a single thing by chipid.

  Raises `Ecto.NoResultsError` if the Thing does not exist.

  ## Examples

      iex> get_thing_by_chipid!(1234)
      %Thing{}

      iex> get_thing_by_chipid!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thing_by_chipid!(chipid), do: Repo.get_by!(Thing, chipid: chipid)

  @doc """
  Creates a thing.

  ## Examples

      iex> create_thing(%{field: value})
      {:ok, %Thing{}}

      iex> create_thing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_thing(attrs \\ %{}) do
    %Thing{}
    |> Thing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a thing.

  ## Examples

      iex> update_thing(thing, %{field: new_value})
      {:ok, %Thing{}}

      iex> update_thing(thing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_thing(%Thing{} = thing, attrs) do
    thing
    |> Thing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Thing.

  ## Examples

      iex> delete_thing(thing)
      {:ok, %Thing{}}

      iex> delete_thing(thing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_thing(%Thing{} = thing) do
    Repo.delete(thing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking thing changes.

  ## Examples

      iex> change_thing(thing)
      %Ecto.Changeset{source: %Thing{}}

  """
  def change_thing(%Thing{} = thing) do
    Thing.changeset(thing, %{})
  end
end
