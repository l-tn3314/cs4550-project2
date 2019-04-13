defmodule Project2.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :ent_id, :integer
      add :type, :string
      add :formatted_msg, :string
      add :time, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:notifications, [:user_id])
  end
end
