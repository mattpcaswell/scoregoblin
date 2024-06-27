defmodule Scoregoblin.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game" do
    field :winner_score, :integer
    field :loser_score, :integer
    field :winner_id, :id
    field :loser_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:winner_score, :loser_score])
    |> validate_required([:winner_score, :loser_score])
  end
end
