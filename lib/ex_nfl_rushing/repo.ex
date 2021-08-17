defmodule NflRushing.Repo do
  use Ecto.Repo,
    otp_app: :ex_nfl_rushing,
    adapter: Ecto.Adapters.Postgres
end
