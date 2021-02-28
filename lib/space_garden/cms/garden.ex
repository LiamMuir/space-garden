defmodule SpaceGarden.CMS.Garden do
  use Ecto.Schema
  import Ecto.Changeset

  alias SpaceGarden.CMS.Author

  schema "gardens" do
    field :name, :string
    belongs_to :author, Author

    timestamps()
  end

  @doc false
  def changeset(garden, attrs) do
    garden
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
