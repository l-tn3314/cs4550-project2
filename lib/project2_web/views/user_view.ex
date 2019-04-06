defmodule Project2Web.UserView do
  use Project2Web, :view
  alias Project2Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user, friend_info: friend_info}) do
    render("user.json", %{user: user, friend_info: friend_info}) 
  end
  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, friend_info: friend_info}) do
    posts = user.posts
    |> Enum.map(fn post -> %{id: post.id, content: post.content, user_id: post.user_id} end)
   
    %{id: user.id,
      email: user.email,
      display_name: user.display_name,
      hometown: user.hometown,
      points: user.points,
      posts: posts,
      is_friend: friend_info.is_friend,
      has_request_from: friend_info.has_request_from,
      sent_request_to: friend_info.sent_request_to}
  end
  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      display_name: user.display_name}
  end


end
