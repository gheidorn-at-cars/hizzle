defmodule Hizzle.Repo do
  use Ecto.Repo,
    otp_app: :hizzle,
    adapter: Ecto.Adapters.Postgres
end
