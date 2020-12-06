defmodule SpaceGardenWeb.SessionController do
  use SpaceGardenWeb, :controller

  def index(conn, _params) do
    oauth_google_url = ElixirAuthGoogle.generate_oauth_url(conn)
    render(conn, "login.html", [oauth_google_url: oauth_google_url])
  end
end
