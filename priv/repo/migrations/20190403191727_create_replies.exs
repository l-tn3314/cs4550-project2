defmodule Project2.Repo.Migrations.CreateReplies do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :content, :string, null: false
      add :time, :utc_datetime, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :post_id, references(:posts, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:replies, [:user_id])
    create index(:replies, [:post_id])
  end
end
