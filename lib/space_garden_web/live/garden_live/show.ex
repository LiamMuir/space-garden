defmodule SpaceGardenWeb.CMS.GardenLive.Show do
  use SpaceGardenWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    {:ok,
      socket
      |> assign_garden_defaults(session)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, params) do
    socket
    |> authorize_garden(params)
    |> assign(:page_title, "Show Garden")
  end

  defp apply_action(socket, :edit, params) do
    socket
    |> authorize_garden(params)
    |> assign(:page_title, "Edit Garden")
  end
end
