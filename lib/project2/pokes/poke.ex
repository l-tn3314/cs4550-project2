defmodule Project2.Pokes.Poke do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokes" do
    field :sender, :id
    field :recipient, :id

    timestamps()
  end

  @doc false
  def changeset(poke, attrs) do
    poke
    |> cast(attrs, [:sender, :recipient])
    |> validate_required([:sender, :recipient])
  end
end
