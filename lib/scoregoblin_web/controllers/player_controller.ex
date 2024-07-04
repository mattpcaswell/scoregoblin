defmodule ScoregoblinWeb.PlayerController do
  use ScoregoblinWeb, :controller

  alias Scoregoblin.Accounts

  def show(conn, %{"id" => id}) do
    player = Accounts.get_user!(id)

    all_games = player.won_games ++ player.lost_games
    player_games = Enum.sort_by(all_games, &(&1.inserted_at), :asc)

    render(conn, :show, player: player, player_games: player_games)
  end
end
