defmodule SpaceGarden.Repo.Migrations.CreateGardens do
  use Ecto.Migration

  def change do
    create table(:gardens) do
      add :name, :string, null: false
      add :author_id, references(:authors, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:gardens, [:author_id])
  end
end
