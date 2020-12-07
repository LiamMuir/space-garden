defmodule SpaceGardenWeb.GoogleAuthController do
  use SpaceGardenWeb, :controller

  alias SpaceGarden.Accounts

  @doc """
  `index/2` handles the callback from Google Auth API redirect.
  """
  def index(conn, %{"code" => code}) do
    {:ok, token} = ElixirAuthGoogle.get_token(code, conn)
    {:ok, profile} = ElixirAuthGoogle.get_user_profile(token.access_token)
    user = Accounts.ensure_user_exists(profile.email)
    conn
    |> put_session(:user_id, user.id)
    # |> put_session(:token, token)
    # |> put_session(:profile, profile)
    |> configure_session(renew: true)
    |> redirect(to: "/")
  end
end
