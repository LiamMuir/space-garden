defmodule SpaceGardenWeb.Router do
  use SpaceGardenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SpaceGardenWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpaceGardenWeb do
    pipe_through :browser

    live "/", AppLive.Index, :index

    live "/demo", PageLive, :index

    get "/auth/google/callback", GoogleAuthController, :index
    get "/login", SessionController, :index

    live "/users", UserLive.Index, :index
    live "/users/:id", UserLive.Show, :show
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :current_user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, SpaceGarden.Accounts.get_user!(user_id))
    end
  end

  scope "/cms", SpaceGardenWeb.CMS, as: :cms do
    pipe_through [:browser, :authenticate_user]

    live "/gardens", GardenLive.Index, :index
    live "/gardens/new", GardenLive.Index, :new
    live "/gardens/:id/edit", GardenLive.Index, :edit

    live "/gardens/:id", GardenLive.Show, :show
    live "/gardens/:id/show/edit", GardenLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpaceGardenWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", ecto_repos: [SpaceGarden.Repo], metrics: SpaceGardenWeb.Telemetry
    end
  end
end
