defmodule Dome.Repo.Migrations.CreateThings do
  use Ecto.Migration

  def change do
    create table(:things) do
      add :name, :string
      add :type, :string
      add :state, :string

      timestamps()
    end

  end
end
