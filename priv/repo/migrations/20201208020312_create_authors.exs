defmodule SpaceGarden.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :role, :string, null: false  # , default: "default"
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:authors, [:user_id])
  end
end
