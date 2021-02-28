defmodule SpaceGardenWeb.GardenLive.FormComponent do
  use SpaceGardenWeb, :live_component

  alias SpaceGarden.CMS

  @impl true
  def update(%{garden: garden} = assigns, socket) do
    changeset = CMS.change_garden(garden)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"garden" => garden_params}, socket) do
    changeset =
      socket.assigns.garden
      |> CMS.change_garden(garden_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"garden" => garden_params}, socket) do
    save_garden(socket, socket.assigns.action, garden_params)
  end

  defp save_garden(socket, :edit, garden_params) do
    case CMS.update_garden(socket.assigns.garden, garden_params) do
      {:ok, _garden} ->
        {:noreply,
         socket
         |> put_flash(:info, "Garden updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_garden(socket, :new, garden_params) do
    case CMS.create_garden(socket.assigns.current_author, garden_params) do
      {:ok, _garden} ->
        {:noreply,
         socket
         |> put_flash(:info, "Garden created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
