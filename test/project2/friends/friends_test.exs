defmodule Project2.FriendsTest do
  use Project2.DataCase

  alias Project2.Friends

  describe "friend_requests" do
    alias Project2.Friends.FriendRequest

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def friend_request_fixture(attrs \\ %{}) do
      {:ok, friend_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Friends.create_friend_request()

      friend_request
    end

    test "list_friend_requests/0 returns all friend_requests" do
      friend_request = friend_request_fixture()
      assert Friends.list_friend_requests() == [friend_request]
    end

    test "get_friend_request!/1 returns the friend_request with given id" do
      friend_request = friend_request_fixture()
      assert Friends.get_friend_request!(friend_request.id) == friend_request
    end

    test "create_friend_request/1 with valid data creates a friend_request" do
      assert {:ok, %FriendRequest{} = friend_request} = Friends.create_friend_request(@valid_attrs)
    end

    test "create_friend_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friends.create_friend_request(@invalid_attrs)
    end

    test "update_friend_request/2 with valid data updates the friend_request" do
      friend_request = friend_request_fixture()
      assert {:ok, %FriendRequest{} = friend_request} = Friends.update_friend_request(friend_request, @update_attrs)
    end

    test "update_friend_request/2 with invalid data returns error changeset" do
      friend_request = friend_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Friends.update_friend_request(friend_request, @invalid_attrs)
      assert friend_request == Friends.get_friend_request!(friend_request.id)
    end

    test "delete_friend_request/1 deletes the friend_request" do
      friend_request = friend_request_fixture()
      assert {:ok, %FriendRequest{}} = Friends.delete_friend_request(friend_request)
      assert_raise Ecto.NoResultsError, fn -> Friends.get_friend_request!(friend_request.id) end
    end

    test "change_friend_request/1 returns a friend_request changeset" do
      friend_request = friend_request_fixture()
      assert %Ecto.Changeset{} = Friends.change_friend_request(friend_request)
    end
  end

  describe "friends" do
    alias Project2.Friends.Friend

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def friend_fixture(attrs \\ %{}) do
      {:ok, friend} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Friends.create_friend()

      friend
    end

    test "list_friends/0 returns all friends" do
      friend = friend_fixture()
      assert Friends.list_friends() == [friend]
    end

    test "get_friend!/1 returns the friend with given id" do
      friend = friend_fixture()
      assert Friends.get_friend!(friend.id) == friend
    end

    test "create_friend/1 with valid data creates a friend" do
      assert {:ok, %Friend{} = friend} = Friends.create_friend(@valid_attrs)
    end

    test "create_friend/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friends.create_friend(@invalid_attrs)
    end

    test "update_friend/2 with valid data updates the friend" do
      friend = friend_fixture()
      assert {:ok, %Friend{} = friend} = Friends.update_friend(friend, @update_attrs)
    end

    test "update_friend/2 with invalid data returns error changeset" do
      friend = friend_fixture()
      assert {:error, %Ecto.Changeset{}} = Friends.update_friend(friend, @invalid_attrs)
      assert friend == Friends.get_friend!(friend.id)
    end

    test "delete_friend/1 deletes the friend" do
      friend = friend_fixture()
      assert {:ok, %Friend{}} = Friends.delete_friend(friend)
      assert_raise Ecto.NoResultsError, fn -> Friends.get_friend!(friend.id) end
    end

    test "change_friend/1 returns a friend changeset" do
      friend = friend_fixture()
      assert %Ecto.Changeset{} = Friends.change_friend(friend)
    end
  end
end
