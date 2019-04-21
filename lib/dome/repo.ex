defmodule Dome.Repo do
  use Ecto.Repo,
    otp_app: :dome,
    adapter: Ecto.Adapters.Postgres
end
