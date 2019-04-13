defmodule Project2.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :ent_id, :integer
    field :formatted_msg, :string
    field :time, :utc_datetime
    field :type, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:ent_id, :type, :formatted_msg, :time])
    |> validate_required([:ent_id, :type, :formatted_msg, :time])
  end
end
