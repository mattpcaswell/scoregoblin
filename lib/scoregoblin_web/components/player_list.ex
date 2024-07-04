defmodule ScoregoblinWeb.PlayerList do
  use ScoregoblinWeb, :html

  attr :players, :list, required: true
  def player_list(assigns) do
    ~H"""
    <.table id="players" rows={@players} bold_first_col={false} row_click={&JS.navigate(~p"/players/#{&1}")}>

      <:col :let={player} label="Name"><%= player.username %></:col>
      <:col :let={player} label="Wins"><%= length(player.won_games) %></:col>
      <:col :let={player} label="Losses"><%= length(player.lost_games) %></:col>
      <:col :let={player} label="Elo"><%= player.elo %></:col>
      <:col :let={player} label="Last played">
        <%= if player_has_games?(player) do %>
          <%= Timex.from_now(get_most_recent_game(player).inserted_at) %>
        <% else %>
          -
        <% end %>
      </:col>

      <:action :let={player}>
        <div class="sr-only">
          <.link navigate={~p"/players/#{player}"}>Show</.link>
        </div>
      </:action>
    </.table>
    """
  end

  defp get_most_recent_game(player) do
    player.won_games ++ player.lost_games
    |> Enum.max_by(&(&1.inserted_at), Date)
  end

  defp player_has_games?(player) do
    length(player.won_games ++ player.lost_games) > 0
  end
end
