defmodule ScoregoblinWeb.PageController do
  use ScoregoblinWeb, :controller

  alias Scoregoblin.Games
  alias Scoregoblin.Accounts

  def home(conn, _params) do
    games = Games.list_games()
    players = Accounts.list_users()
    render(conn, :home, games: games, players: players)
  end
end
