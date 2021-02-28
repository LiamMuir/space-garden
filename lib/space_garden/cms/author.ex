defmodule SpaceGarden.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset

  alias SpaceGarden.CMS.Garden

  schema "authors" do
    field :role, :string
    belongs_to :user, SpaceGarden.Accounts.User
    has_many :gardens, Garden

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:role])
    |> validate_required([:role])
    |> unique_constraint(:user_id)
  end
end
