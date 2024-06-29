defmodule Scoregoblin.Repo.Migrations.GameOwnership do
  use Ecto.Migration

  def change do
    alter table(:game) do
      add :creator, references(:users, on_delete: :nothing)
    end

    create index(:game, [:creator])
  end
end
