defmodule ScoregoblinWeb.GameList do
  use ScoregoblinWeb, :html

  attr :games, :list, required: true
  attr :quick_edit, :boolean, default: false
  def game_list(assigns) do
    ~H"""
    <.table id="games" rows={@games} bold_first_col={false} row_click={&JS.navigate(~p"/games/#{&1}")}>

      <:col :let={game} label="Winner"><%= game.winner.username %></:col>
      <:col :let={game} label="Winner score"><%= game.winner_score %></:col>
      <:col :let={game} label="Loser score"><%= game.loser_score %></:col>
      <:col :let={game} label="Loser"><%= game.loser.username %></:col>
      <:col :let={game} label="Date"><%= Timex.from_now(game.inserted_at)%></:col>

      <:action :let={game}>
        <div class="sr-only">
          <.link navigate={~p"/games/#{game}"}>Show</.link>
        </div>
        <%= if @quick_edit do %>
          <.link navigate={~p"/games/#{game}/edit"}>Edit</.link>
        <% end %>
      </:action>
      <:action :let={game}>
        <%= if @quick_edit do %>
          <.link href={~p"/games/#{game}"} method="delete" data-confirm="Are you sure?">
            Delete
          </.link>
        <% end %>
      </:action>
    </.table>
    """
  end
end
