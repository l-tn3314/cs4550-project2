defmodule Project2.Friends.FriendRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friend_requests" do
    field :sender_id, :id
    field :receiver_id, :id

    timestamps()
  end

  @doc false
  def changeset(friend_request, attrs) do
    friend_request
    |> cast(attrs, [:sender_id, :receiver_id])
    |> validate_required([:sender_id, :receiver_id])
  end
end
