defmodule Project2.Pokes do
  @moduledoc """
  The Pokes context.
  """

  import Ecto.Query, warn: false
  alias Project2.Repo

  alias Project2.Pokes.Poke

  @doc """
  Returns the list of pokes.

  ## Examples

      iex> list_pokes()
      [%Poke{}, ...]

  """
  def list_pokes do
    Repo.all(Poke)
  end

  @doc """
  Gets a single poke.

  Raises `Ecto.NoResultsError` if the Poke does not exist.

  ## Examples

      iex> get_poke!(123)
      %Poke{}

      iex> get_poke!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poke!(id), do: Repo.get!(Poke, id)

  @doc """
  Creates a poke.

  ## Examples

      iex> create_poke(%{field: value})
      {:ok, %Poke{}}

      iex> create_poke(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poke(attrs \\ %{}) do
    %Poke{}
    |> Poke.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poke.

  ## Examples

      iex> update_poke(poke, %{field: new_value})
      {:ok, %Poke{}}

      iex> update_poke(poke, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poke(%Poke{} = poke, attrs) do
    poke
    |> Poke.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Poke.

  ## Examples

      iex> delete_poke(poke)
      {:ok, %Poke{}}

      iex> delete_poke(poke)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poke(%Poke{} = poke) do
    Repo.delete(poke)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poke changes.

  ## Examples

      iex> change_poke(poke)
      %Ecto.Changeset{source: %Poke{}}

  """
  def change_poke(%Poke{} = poke) do
    Poke.changeset(poke, %{})
  end
end
