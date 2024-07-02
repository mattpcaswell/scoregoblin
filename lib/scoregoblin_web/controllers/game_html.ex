defmodule ScoregoblinWeb.GameHTML do
  use ScoregoblinWeb, :html

  embed_templates "game_html/*"

  @doc """
  Renders a game form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :all_usernames, :list, required: true
  attr :action, :string, required: true

  def game_form(assigns)
end
