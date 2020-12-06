defmodule SpaceGardenWeb.GoogleAuthController do
  use SpaceGardenWeb, :controller

  @doc """
  `index/2` handles the callback from Google Auth API redirect.
  """
  def index(conn, %{"code" => code}) do
    {:ok, token} = ElixirAuthGoogle.get_token(code, conn)
    {:ok, profile} = ElixirAuthGoogle.get_user_profile(token.access_token)
    conn
    |> put_session(:token, token)
    |> put_session(:profile, profile)
    |> redirect(to: "/")
  end
end
