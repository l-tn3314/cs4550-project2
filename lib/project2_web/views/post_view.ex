defmodule Project2Web.PostView do
  use Project2Web, :view
  alias Project2Web.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    replies = post.replies
    |> Enum.map(fn reply -> %{id: reply.id, content: reply.content, time: reply.time, username: reply.user.display_name, user_id: reply.user_id} end)

    %{id: post.id,
      content: post.content,
      time: post.time,
      replies: replies,
      username: post.user.display_name,
      user_id: post.user.id}
  end
end
