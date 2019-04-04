defmodule Project2Web.FriendRequestView do
  use Project2Web, :view
  alias Project2Web.FriendRequestView

  def render("index.json", %{friend_requests: friend_requests}) do
    %{data: render_many(friend_requests, FriendRequestView, "friend_request.json")}
  end

  def render("show.json", %{friend_request: friend_request}) do
    %{data: render_one(friend_request, FriendRequestView, "friend_request.json")}
  end

  def render("friend_request.json", %{friend_request: friend_request}) do
    %{id: friend_request.id}
  end
end
