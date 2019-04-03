defmodule Project2Web.ReplyView do
  use Project2Web, :view
  alias Project2Web.ReplyView

  def render("index.json", %{replies: replies}) do
    %{data: render_many(replies, ReplyView, "reply.json")}
  end

  def render("show.json", %{reply: reply}) do
    %{data: render_one(reply, ReplyView, "reply.json")}
  end

  def render("reply.json", %{reply: reply}) do
    %{id: reply.id,
      content: reply.content,
      time: reply.time}
  end
end
