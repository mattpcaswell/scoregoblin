defmodule ScoregoblinWeb.PlayerHTML do
  use ScoregoblinWeb, :html

  embed_templates "player_html/*"

  attr :player, Scoregoblin.Accounts.User, required: true
  def show(assigns)
end
