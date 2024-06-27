defmodule ScoregoblinWeb.GameLive.Index do
  use ScoregoblinWeb, :live_view

  alias Scoregoblin.Games
  alias Scoregoblin.Games.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :game_collection, Games.list_game())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Game")
    |> assign(:game, Games.get_game!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Game")
    |> assign(:game, %Game{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Game")
    |> assign(:game, nil)
  end

  @impl true
  def handle_info({ScoregoblinWeb.GameLive.FormComponent, {:saved, game}}, socket) do
    {:noreply, stream_insert(socket, :game_collection, game)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    game = Games.get_game!(id)
    {:ok, _} = Games.delete_game(game)

    {:noreply, stream_delete(socket, :game_collection, game)}
  end
end
