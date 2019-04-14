defmodule Project2.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :ent_id, :integer
    field :formatted_msg, :string
    field :time, :utc_datetime
    field :type, :string
    field :actor_id, :id # user that caused the notif to be sent
    belongs_to :user, Project2.Users.User

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:ent_id, :type, :formatted_msg, :time, :user_id, :actor_id])
    |> validate_required([:ent_id, :type, :time, :user_id])
  end
end
