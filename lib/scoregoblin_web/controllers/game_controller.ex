defmodule ScoregoblinWeb.GameController do
  use ScoregoblinWeb, :controller

  alias Scoregoblin.Games
  alias Scoregoblin.Games.Game

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, :index, games: games)
  end

  def new(conn, _params) do
    changeset = Games.change_game(%Game{})

    all_users = Scoregoblin.Accounts.list_users()
    all_usernames = Enum.map(all_users, &({&1.username, &1.id}))

    render(conn, :new, changeset: changeset, all_usernames: all_usernames)
  end

  def create(conn, %{"game" => game_params}) do
    all_users = Scoregoblin.Accounts.list_users()
    all_usernames = Enum.map(all_users, &({&1.username, &1.id}))

    case Games.create_game(conn.assigns.current_user, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: ~p"/games/#{game}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, all_usernames: all_usernames)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    render(conn, :show, game: game)
  end

  def edit(conn, %{"id" => id}) do
    all_users = Scoregoblin.Accounts.list_users()
    all_usernames = Enum.map(all_users, &({&1.username, &1.id}))

    game = Games.get_game!(id)
    changeset = Games.change_game(game)
    render(conn, :edit, game: game, all_usernames: all_usernames, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    all_users = Scoregoblin.Accounts.list_users()
    all_usernames = Enum.map(all_users, &({&1.username, &1.id}))
    game = Games.get_game!(id)

    case Games.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: ~p"/games/#{game}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, game: game, all_usernames: all_usernames, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    {:ok, _game} = Games.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: ~p"/games")
  end
end
