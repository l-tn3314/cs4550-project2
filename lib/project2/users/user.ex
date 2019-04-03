defmodule Project2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :display_name, :string
    field :email, :string
    field :password_hash, :string
    field :points, :integer
    field :hometown, :string
    field :pw_last_try, :utc_datetime
    has_many :friends, User

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :display_name, :password_hash, :points, :hometown])
    |> validate_required([:email, :display_name, :password_hash, :points, :hometown])
    |> unique_constraint(:email)
  end
end
