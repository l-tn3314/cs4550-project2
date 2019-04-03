defmodule Project2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :display_name, :string, null: false
      add :password_hash, :string, null: false
      add :points, :integer, default: 0
      add :hometown, :string, null: false
      add :pw_last_try, :utc_datetime

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
