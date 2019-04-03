defmodule Project2.RepliesTest do
  use Project2.DataCase

  alias Project2.Replies

  describe "replies" do
    alias Project2.Replies.Reply

    @valid_attrs %{content: "some content", time: "2010-04-17T14:00:00Z"}
    @update_attrs %{content: "some updated content", time: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{content: nil, time: nil}

    def reply_fixture(attrs \\ %{}) do
      {:ok, reply} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Replies.create_reply()

      reply
    end

    test "list_replies/0 returns all replies" do
      reply = reply_fixture()
      assert Replies.list_replies() == [reply]
    end

    test "get_reply!/1 returns the reply with given id" do
      reply = reply_fixture()
      assert Replies.get_reply!(reply.id) == reply
    end

    test "create_reply/1 with valid data creates a reply" do
      assert {:ok, %Reply{} = reply} = Replies.create_reply(@valid_attrs)
      assert reply.content == "some content"
      assert reply.time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_reply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Replies.create_reply(@invalid_attrs)
    end

    test "update_reply/2 with valid data updates the reply" do
      reply = reply_fixture()
      assert {:ok, %Reply{} = reply} = Replies.update_reply(reply, @update_attrs)
      assert reply.content == "some updated content"
      assert reply.time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_reply/2 with invalid data returns error changeset" do
      reply = reply_fixture()
      assert {:error, %Ecto.Changeset{}} = Replies.update_reply(reply, @invalid_attrs)
      assert reply == Replies.get_reply!(reply.id)
    end

    test "delete_reply/1 deletes the reply" do
      reply = reply_fixture()
      assert {:ok, %Reply{}} = Replies.delete_reply(reply)
      assert_raise Ecto.NoResultsError, fn -> Replies.get_reply!(reply.id) end
    end

    test "change_reply/1 returns a reply changeset" do
      reply = reply_fixture()
      assert %Ecto.Changeset{} = Replies.change_reply(reply)
    end
  end
end
