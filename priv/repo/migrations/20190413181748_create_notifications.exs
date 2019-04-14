defmodule Project2.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :ent_id, :integer, null: false
      add :type, :string, null: false
      add :formatted_msg, :string
      add :time, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :actor_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:notifications, [:user_id])
  end
end
