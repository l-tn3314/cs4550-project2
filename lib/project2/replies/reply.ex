defmodule Project2.Replies.Reply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "replies" do
    field :content, :string
    field :time, :utc_datetime
    field :user_id, :id
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(reply, attrs) do
    reply
    |> cast(attrs, [:content, :user_id, :post_id, :time])
    |> validate_required([:content, :user_id, :post_id, :time])
  end
end
