defmodule Project2.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :time, :utc_datetime
    has_many :replies, Project2.Replies.Reply
    belongs_to :user, Project2.Users.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :user_id, :time])
    |> validate_required([:content, :user_id, :time])
  end
end
