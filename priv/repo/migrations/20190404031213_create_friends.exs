defmodule Project2.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :lower_user_id, references(:users, on_delete: :nothing)
      add :higher_user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:friends, [:lower_user_id])
    create index(:friends, [:higher_user_id])

    create unique_index(:friends, [:lower_user_id, :higher_user_id])
  end
end
