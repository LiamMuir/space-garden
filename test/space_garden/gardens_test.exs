defmodule SpaceGarden.GardensTest do
  use SpaceGarden.DataCase

  alias SpaceGarden.Gardens

  describe "authors" do
    alias SpaceGarden.Gardens.Author

    @valid_attrs %{role: "some role"}
    @update_attrs %{role: "some updated role"}
    @invalid_attrs %{role: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Gardens.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Gardens.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Gardens.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Gardens.create_author(@valid_attrs)
      assert author.role == "some role"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gardens.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = Gardens.update_author(author, @update_attrs)
      assert author.role == "some updated role"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Gardens.update_author(author, @invalid_attrs)
      assert author == Gardens.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Gardens.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Gardens.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Gardens.change_author(author)
    end
  end

  describe "gardens" do
    alias SpaceGarden.Gardens.Garden

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def garden_fixture(attrs \\ %{}) do
      {:ok, garden} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Gardens.create_garden()

      garden
    end

    test "list_gardens/0 returns all gardens" do
      garden = garden_fixture()
      assert Gardens.list_gardens() == [garden]
    end

    test "get_garden!/1 returns the garden with given id" do
      garden = garden_fixture()
      assert Gardens.get_garden!(garden.id) == garden
    end

    test "create_garden/1 with valid data creates a garden" do
      assert {:ok, %Garden{} = garden} = Gardens.create_garden(@valid_attrs)
      assert garden.name == "some name"
    end

    test "create_garden/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gardens.create_garden(@invalid_attrs)
    end

    test "update_garden/2 with valid data updates the garden" do
      garden = garden_fixture()
      assert {:ok, %Garden{} = garden} = Gardens.update_garden(garden, @update_attrs)
      assert garden.name == "some updated name"
    end

    test "update_garden/2 with invalid data returns error changeset" do
      garden = garden_fixture()
      assert {:error, %Ecto.Changeset{}} = Gardens.update_garden(garden, @invalid_attrs)
      assert garden == Gardens.get_garden!(garden.id)
    end

    test "delete_garden/1 deletes the garden" do
      garden = garden_fixture()
      assert {:ok, %Garden{}} = Gardens.delete_garden(garden)
      assert_raise Ecto.NoResultsError, fn -> Gardens.get_garden!(garden.id) end
    end

    test "change_garden/1 returns a garden changeset" do
      garden = garden_fixture()
      assert %Ecto.Changeset{} = Gardens.change_garden(garden)
    end
  end
end
