defmodule SpaceGarden.Repo.Migrations.CreatePlants do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :name, :string, null: false
      add :author_id, references(:authors, on_delete: :delete_all), null: false
      add :garden_id, references(:gardens, on_delete: :delete_all), null: false
      add :category_id, references(:categories), null: false

      timestamps()
    end

    create index(:plants, [:author_id])
  end
end
