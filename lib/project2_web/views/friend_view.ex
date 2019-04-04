defmodule Project2Web.FriendView do
  use Project2Web, :view
  alias Project2Web.FriendView

  def render("index.json", %{friends: friends}) do
    %{data: render_many(friends, FriendView, "friend.json")}
  end

  def render("show.json", %{friend: friend}) do
    %{data: render_one(friend, FriendView, "friend.json")}
  end

  def render("friend.json", %{friend: friend}) do
    %{id: friend.id}
  end
end
