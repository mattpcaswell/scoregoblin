defmodule ScoregoblinWeb.PageController do
  use ScoregoblinWeb, :controller

  alias Scoregoblin.Games

  def home(conn, _params) do
    games = Games.list_games()
    render(conn, :home, games: games)
  end
end
