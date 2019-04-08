defmodule Project2.Repo.Migrations.CreatePokes do
  use Ecto.Migration

  def change do
    create table(:pokes) do
      add :sender, references(:users, on_delete: :delete_all), null: false
      add :recipient, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:pokes, [:sender])
    create index(:pokes, [:recipient])
  end
end
