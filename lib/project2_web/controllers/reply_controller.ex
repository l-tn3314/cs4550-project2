defmodule Project2Web.ReplyController do
  use Project2Web, :controller

  alias Project2.Replies
  alias Project2.Replies.Reply

  action_fallback Project2Web.FallbackController

  def index(conn, _params) do
    replies = Replies.list_replies()
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"reply" => reply_params}) do
    with {:ok, %Reply{} = reply} <- Replies.create_reply(reply_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.reply_path(conn, :show, reply))
      |> render("show.json", reply: reply)
    end
  end

  def show(conn, %{"id" => id}) do
    reply = Replies.get_reply!(id)
    render(conn, "show.json", reply: reply)
  end

  def update(conn, %{"id" => id, "reply" => reply_params}) do
    reply = Replies.get_reply!(id)

    with {:ok, %Reply{} = reply} <- Replies.update_reply(reply, reply_params) do
      render(conn, "show.json", reply: reply)
    end
  end

  def delete(conn, %{"id" => id}) do
    reply = Replies.get_reply!(id)

    with {:ok, %Reply{}} <- Replies.delete_reply(reply) do
      send_resp(conn, :no_content, "")
    end
  end
end
