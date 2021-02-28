defmodule SpaceGarden.CMS.Plant do
  use Ecto.Schema
  import Ecto.Changeset

  alias SpaceGarden.CMS.{Author, Garden, Category}

  schema "plants" do
    field :name, :string
    belongs_to :author, Author
    belongs_to :garden, Garden
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(plant, attrs) do
    plant
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
