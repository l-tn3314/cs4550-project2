defmodule Project2.Repo.Migrations.CreateReplies do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :content, :string
      add :time, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:replies, [:user_id])
    create index(:replies, [:post_id])
  end
end
