defmodule Project2.Replies.Reply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "replies" do
    field :content, :string
    field :time, :utc_datetime
    belongs_to :user, Project2.Users.User
    belongs_to :post, Project2.Posts.Post
    timestamps()
  end

  @doc false
  def changeset(reply, attrs) do
    reply
    |> cast(attrs, [:content, :user_id, :post_id, :time])
    |> validate_required([:content, :user_id, :post_id, :time])
  end
end
