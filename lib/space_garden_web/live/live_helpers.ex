defmodule SpaceGardenWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias SpaceGarden.Accounts
  alias SpaceGarden.CMS

  @doc """
  Renders a component inside the `SpaceGardenWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, SpaceGardenWeb.UserLive.FormComponent,
        id: @user.id || :new,
        action: @live_action,
        user: @user,
        return_to: Routes.user_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, SpaceGardenWeb.ModalComponent, modal_opts)
  end

  def assign_garden_defaults(socket, %{"current_user_id" => current_user_id}) do
    user = Accounts.get_user!(current_user_id)
    author = CMS.ensure_author_exists(user)

    socket
    |> assign(:current_author, author)
  end

  def authorize_garden(socket, %{"id" => garden_id}) do
    garden = CMS.get_garden!(garden_id)

    if socket.assigns.current_author.id == garden.author_id do
      socket
      |> assign(:garden, garden)
    else
      socket
      |> put_flash(:error, "You can't modify that garden")
      |> redirect(to: Routes.cms_garden_path(socket, :index))
    end
  end
end
