defmodule SpaceGardenWeb.GardenLiveTest do
  use SpaceGardenWeb.ConnCase

  import Phoenix.LiveViewTest

  alias SpaceGarden.Gardens

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:garden) do
    {:ok, garden} = Gardens.create_garden(@create_attrs)
    garden
  end

  defp create_garden(_) do
    garden = fixture(:garden)
    %{garden: garden}
  end

  describe "Index" do
    setup [:create_garden]

    test "lists all gardens", %{conn: conn, garden: garden} do
      {:ok, _index_live, html} = live(conn, Routes.garden_index_path(conn, :index))

      assert html =~ "Listing Gardens"
      assert html =~ garden.name
    end

    test "saves new garden", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.garden_index_path(conn, :index))

      assert index_live |> element("a", "New Garden") |> render_click() =~
               "New Garden"

      assert_patch(index_live, Routes.garden_index_path(conn, :new))

      assert index_live
             |> form("#garden-form", garden: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#garden-form", garden: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.garden_index_path(conn, :index))

      assert html =~ "Garden created successfully"
      assert html =~ "some name"
    end

    test "updates garden in listing", %{conn: conn, garden: garden} do
      {:ok, index_live, _html} = live(conn, Routes.garden_index_path(conn, :index))

      assert index_live |> element("#garden-#{garden.id} a", "Edit") |> render_click() =~
               "Edit Garden"

      assert_patch(index_live, Routes.garden_index_path(conn, :edit, garden))

      assert index_live
             |> form("#garden-form", garden: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#garden-form", garden: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.garden_index_path(conn, :index))

      assert html =~ "Garden updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes garden in listing", %{conn: conn, garden: garden} do
      {:ok, index_live, _html} = live(conn, Routes.garden_index_path(conn, :index))

      assert index_live |> element("#garden-#{garden.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#garden-#{garden.id}")
    end
  end

  describe "Show" do
    setup [:create_garden]

    test "displays garden", %{conn: conn, garden: garden} do
      {:ok, _show_live, html} = live(conn, Routes.garden_show_path(conn, :show, garden))

      assert html =~ "Show Garden"
      assert html =~ garden.name
    end

    test "updates garden within modal", %{conn: conn, garden: garden} do
      {:ok, show_live, _html} = live(conn, Routes.garden_show_path(conn, :show, garden))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Garden"

      assert_patch(show_live, Routes.garden_show_path(conn, :edit, garden))

      assert show_live
             |> form("#garden-form", garden: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#garden-form", garden: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.garden_show_path(conn, :show, garden))

      assert html =~ "Garden updated successfully"
      assert html =~ "some updated name"
    end
  end
end
