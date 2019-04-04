defmodule Project2.Repo.Migrations.CreateFriendRequests do
  use Ecto.Migration

  def change do
    create table(:friend_requests) do
      add :sender_id, references(:users, on_delete: :delete_all), null: false
      add :receiver_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:friend_requests, [:sender_id])
    create index(:friend_requests, [:receiver_id])
    
    create unique_index(:friend_requests, [:sender_id, :receiver_id])
  end
end
