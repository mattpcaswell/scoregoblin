defmodule Scoregoblin.Repo.Migrations.AddElo do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :elo, :integer, default: 1000
    end

    alter table(:games) do
      add :winner_pre_game_elo, :integer
      add :loser_pre_game_elo, :integer
    end
  end
end
