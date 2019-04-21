defmodule Dome.Repo.Migrations.AddChipidToThings do
  use Ecto.Migration

  def change do
    alter table(:things) do
      add :chipid, :string
    end
  end
end
