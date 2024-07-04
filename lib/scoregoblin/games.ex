defmodule Scoregoblin.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Scoregoblin.Repo

  alias Scoregoblin.Games.Game

  @doc """
  Returns the list of game.

  ## Examples

      iex> list_game()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all from game in Game, 
      preload: [:winner, :loser, :creator],
      order_by: [desc: :inserted_at]
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id) do
    Repo.get!(Game, id)
    |> Repo.preload([:winner, :loser, :creator])
  end

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(creator, attrs \\ %{}) do
    winner = Scoregoblin.Accounts.get_user!(attrs["winner_id"])
    loser  = Scoregoblin.Accounts.get_user!(attrs["loser_id"])

    attrs = Map.put(attrs, "creator_id", creator.id)
    attrs = Map.put(attrs, "winner_pre_game_elo", winner.elo)
    attrs = Map.put(attrs, "loser_pre_game_elo", loser.elo)

    add_game_changeset = Game.changeset(%Game{}, attrs)

    with {:ok, game} <- Repo.insert(add_game_changeset) do
      Scoregoblin.Accounts.elo_update(game, winner, loser)
      {:ok, game}
    end
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end
end
