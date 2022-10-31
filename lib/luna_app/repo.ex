defmodule LunaApp.Repo do
  use Ecto.Repo,
    otp_app: :luna_app,
    adapter: Ecto.Adapters.Postgres
end
