defmodule SpaceGardenWeb.CMS.GardenLive.Index do
  use SpaceGardenWeb, :live_view

  alias SpaceGarden.CMS
  alias SpaceGarden.CMS.Garden

  @impl true
  def mount(_params, session, socket) do
    {:ok,
      socket
      |> assign_garden_defaults(session)
      |> assign(:gardens, CMS.list_gardens())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, params) do
    socket
    |> authorize_garden(params)
    |> assign(:page_title, "Edit Garden")
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Garden")
    |> assign(:garden, %Garden{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gardens")
    |> assign(:garden, nil)
  end

  @impl true
  def handle_event("delete", params, socket) do
    socket
    |> authorize_garden(params)

    {:ok, _} = CMS.delete_garden(socket.assigns.garden)

    {:noreply, assign(socket, :gardens, CMS.list_gardens())}
  end
end
