defmodule Project2.Friends do
  @moduledoc """
  The Friends context.
  """

  import Ecto.Query, warn: false
  alias Project2.Repo

  alias Project2.Friends.FriendRequest

  @doc """
  Returns the list of friend_requests.

  ## Examples

      iex> list_friend_requests()
      [%FriendRequest{}, ...]

  """
  def list_friend_requests do
    Repo.all(FriendRequest)
  end

  # returns tuple of friend requests sent_to other users, and received_from other users
  def get_friend_requests_for(id) do
    friend_request_query = from f in FriendRequest,
      where: f.sender_id == ^id or f.receiver_id == ^id
    friend_requests = Repo.all(friend_request_query)
    {id_val, _} = Integer.parse(id)
    sent_to = friend_requests
      |> Enum.filter(fn relation -> relation.sender_id == id_val end)
      |> Enum.map(fn relation -> relation.receiver_id end)
    received_from = friend_requests
      |> Enum.filter(fn relation -> relation.receiver_id == id_val end)
      |> Enum.map(fn relation -> relation.sender_id end)
    {sent_to, received_from}
  end

  @doc """
  Gets a single friend_request.

  Raises `Ecto.NoResultsError` if the Friend request does not exist.

  ## Examples

      iex> get_friend_request!(123)
      %FriendRequest{}

      iex> get_friend_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_friend_request!(id), do: Repo.get!(FriendRequest, id)

  @doc """
  Creates a friend_request.

  ## Examples

      iex> create_friend_request(%{field: value})
      {:ok, %FriendRequest{}}

      iex> create_friend_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_friend_request(attrs \\ %{}) do
    %FriendRequest{}
    |> FriendRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a friend_request.

  ## Examples

      iex> update_friend_request(friend_request, %{field: new_value})
      {:ok, %FriendRequest{}}

      iex> update_friend_request(friend_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_friend_request(%FriendRequest{} = friend_request, attrs) do
    friend_request
    |> FriendRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FriendRequest.

  ## Examples

      iex> delete_friend_request(friend_request)
      {:ok, %FriendRequest{}}

      iex> delete_friend_request(friend_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_friend_request(%FriendRequest{} = friend_request) do
    Repo.delete(friend_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking friend_request changes.

  ## Examples

      iex> change_friend_request(friend_request)
      %Ecto.Changeset{source: %FriendRequest{}}

  """
  def change_friend_request(%FriendRequest{} = friend_request) do
    FriendRequest.changeset(friend_request, %{})
  end

  alias Project2.Friends.Friend

  @doc """
  Returns the list of friends.

  ## Examples

      iex> list_friends()
      [%Friend{}, ...]

  """
  def list_friends do
    Repo.all(Friend)
  end

  def get_friend_ids_for(id) do
    friends_id_query = from f in Friend,
      where: f.lower_user_id == ^id or f.higher_user_id == ^id
    {id_val, _} = Integer.parse(id)
    Repo.all(friends_id_query)
    |> Enum.map(fn relation -> 
        if relation.lower_user_id == id_val do
          relation.higher_user_id
        else 
          relation.lower_user_id
        end
      end)
  end

  @doc """
  Gets a single friend.

  Raises `Ecto.NoResultsError` if the Friend does not exist.

  ## Examples

      iex> get_friend!(123)
      %Friend{}

      iex> get_friend!(456)
      ** (Ecto.NoResultsError)

  """
  def get_friend!(id), do: Repo.get!(Friend, id)

  @doc """
  Creates a friend.

  ## Examples

      iex> create_friend(%{field: value})
      {:ok, %Friend{}}

      iex> create_friend(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_friend(attrs \\ %{}) do
    %Friend{}
    |> Friend.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a friend.

  ## Examples

      iex> update_friend(friend, %{field: new_value})
      {:ok, %Friend{}}

      iex> update_friend(friend, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_friend(%Friend{} = friend, attrs) do
    friend
    |> Friend.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Friend.

  ## Examples

      iex> delete_friend(friend)
      {:ok, %Friend{}}

      iex> delete_friend(friend)
      {:error, %Ecto.Changeset{}}

  """
  def delete_friend(%Friend{} = friend) do
    Repo.delete(friend)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking friend changes.

  ## Examples

      iex> change_friend(friend)
      %Ecto.Changeset{source: %Friend{}}

  """
  def change_friend(%Friend{} = friend) do
    Friend.changeset(friend, %{})
  end
end
