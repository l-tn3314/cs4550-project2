defmodule Project2Web.UserView do
  use Project2Web, :view
  alias Project2Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user, friends: friends}) do
    render("user.json", %{user: user, friends: friends}) 
  end
  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, friends: friends}) do
    %{id: user.id,
      email: user.email,
      display_name: user.display_name,
      password_hash: user.password_hash,
      friends: friends}
  end
  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      display_name: user.display_name,
      password_hash: user.password_hash}
  end


end
