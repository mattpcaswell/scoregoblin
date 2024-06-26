defmodule Scoregoblin.Repo do
  use Ecto.Repo,
    otp_app: :scoregoblin,
    adapter: Ecto.Adapters.Postgres
end
