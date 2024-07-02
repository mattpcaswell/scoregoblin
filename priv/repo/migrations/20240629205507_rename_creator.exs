defmodule Scoregoblin.Repo.Migrations.RenameCreator do
  use Ecto.Migration

  def change do
    rename table(:game), :creator, to: :creator_id
  end
end
