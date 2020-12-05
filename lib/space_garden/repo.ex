defmodule SpaceGarden.Repo do
  use Ecto.Repo,
    otp_app: :space_garden,
    adapter: Ecto.Adapters.Postgres
end
