defmodule Scoregoblin.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Scoregoblin.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        loser_score: 42,
        winner_score: 42
      })
      |> Scoregoblin.Games.create_game()

    game
  end
end
