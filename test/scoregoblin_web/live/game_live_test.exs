defmodule ScoregoblinWeb.GameLiveTest do
  use ScoregoblinWeb.ConnCase

  import Phoenix.LiveViewTest
  import Scoregoblin.GamesFixtures

  @create_attrs %{winner_score: 42, loser_score: 42}
  @update_attrs %{winner_score: 43, loser_score: 43}
  @invalid_attrs %{winner_score: nil, loser_score: nil}

  defp create_game(_) do
    game = game_fixture()
    %{game: game}
  end

  describe "Index" do
    setup [:create_game]

    test "lists all game", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/game")

      assert html =~ "Listing Game"
    end

    test "saves new game", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/game")

      assert index_live |> element("a", "New Game") |> render_click() =~
               "New Game"

      assert_patch(index_live, ~p"/game/new")

      assert index_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#game-form", game: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/game")

      html = render(index_live)
      assert html =~ "Game created successfully"
    end

    test "updates game in listing", %{conn: conn, game: game} do
      {:ok, index_live, _html} = live(conn, ~p"/game")

      assert index_live |> element("#game-#{game.id} a", "Edit") |> render_click() =~
               "Edit Game"

      assert_patch(index_live, ~p"/game/#{game}/edit")

      assert index_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#game-form", game: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/game")

      html = render(index_live)
      assert html =~ "Game updated successfully"
    end

    test "deletes game in listing", %{conn: conn, game: game} do
      {:ok, index_live, _html} = live(conn, ~p"/game")

      assert index_live |> element("#game-#{game.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#game-#{game.id}")
    end
  end

  describe "Show" do
    setup [:create_game]

    test "displays game", %{conn: conn, game: game} do
      {:ok, _show_live, html} = live(conn, ~p"/game/#{game}")

      assert html =~ "Show Game"
    end

    test "updates game within modal", %{conn: conn, game: game} do
      {:ok, show_live, _html} = live(conn, ~p"/game/#{game}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Game"

      assert_patch(show_live, ~p"/game/#{game}/show/edit")

      assert show_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#game-form", game: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/game/#{game}")

      html = render(show_live)
      assert html =~ "Game updated successfully"
    end
  end
end
