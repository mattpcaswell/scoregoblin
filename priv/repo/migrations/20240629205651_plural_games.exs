defmodule Scoregoblin.Repo.Migrations.PluralGames do
  use Ecto.Migration

  def change do
    rename table(:game), to: table(:games)
  end
end
