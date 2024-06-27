defmodule Scoregoblin.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:game) do
      add :winner_score, :integer
      add :loser_score, :integer
      add :winner_id, references(:users, on_delete: :nothing)
      add :loser_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:game, [:winner_id])
    create index(:game, [:loser_id])
  end
end
