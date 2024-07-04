defmodule Scoregoblin.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :winner_score, :integer
    field :loser_score, :integer

    field :winner_pre_game_elo, :integer
    field :loser_pre_game_elo, :integer

    belongs_to :winner, Scoregoblin.Accounts.User
    belongs_to :loser, Scoregoblin.Accounts.User

    belongs_to :creator, Scoregoblin.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:winner_score, :loser_score, :winner_id, :loser_id, :creator_id, :winner_pre_game_elo, :loser_pre_game_elo])
    |> assoc_constraint(:winner)
    |> assoc_constraint(:loser)
    |> assoc_constraint(:creator)
    |> validate_required([:winner_score, :loser_score, :winner_id, :loser_id, :creator_id, :winner_pre_game_elo, :loser_pre_game_elo])
    |> validate_number(:loser_score, greater_than_or_equal_to: 0)
    |> validate_greater_than(:winner_score, :loser_score)
    |> validate_different(:winner_id, :loser_id)
  end

  defp validate_greater_than(changeset, greater_field, lesser_field) do
    {_, greater_value} = fetch_field(changeset, greater_field)
    {_, lesser_value} = fetch_field(changeset, lesser_field)

    if greater_value > lesser_value do
      changeset
    else
      add_error(
        changeset,
        greater_field,
        "%{greater_field} is not greater than %{lesser_field}",
        greater_field: greater_field,
        lesser_field: lesser_field
      )
    end
  end

  defp validate_different(changeset, field_a, field_b) do
    {_, value_a} = fetch_field(changeset, field_a)
    {_, value_b} = fetch_field(changeset, field_b)

    if value_a != value_b do
      changeset
    else
      add_error(
        changeset,
        field_a,
        "%{field_a} must not be the same as %{field_b}",
        field_a: field_a,
        field_b: field_b
      )
    end
  end
end
