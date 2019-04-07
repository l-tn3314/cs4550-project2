defmodule Project2Web.ReplyController do
  use Project2Web, :controller

  alias Project2.Replies
  alias Project2.Replies.Reply

  action_fallback Project2Web.FallbackController

  plug Project2Web.Plugs.RequireAuth when action in [:create, :update, :delete]
  
  def index(conn, _params) do
    replies = Replies.list_replies()
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"reply" => reply_params}) do
    reply_params = Map.put(reply_params, "user_id", conn.assigns.current_user.id)
    
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

    if reply.user_id == conn.assigns.current_user.id do 
      with {:ok, %Reply{}} <- Replies.delete_reply(reply) do
        send_resp(conn, :no_content, "")
      end
    else 
      conn 
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:unprocessable_entity, Jason.encode!(%{"error" => "not authorized!"}) )
    end
  end
end
