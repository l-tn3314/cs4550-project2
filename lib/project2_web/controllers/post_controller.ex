defmodule Project2Web.PostController do
  use Project2Web, :controller

  alias Project2.Posts
  alias Project2.Posts.Post

  action_fallback Project2Web.FallbackController

  plug Project2Web.Plugs.RequireAuth when action in [:create, :update, :delete]

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    post_params = Map.put(post_params, "user_id", conn.assigns.current_user.id)

    with {:ok, %Post{} = post} <- Posts.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("index.json", posts: []) # a little hacky? this value doesn't really matter
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    if post.user_id == conn.assigns.current_user.id do 
      with {:ok, %Post{}} <- Posts.delete_post(post) do
        send_resp(conn, :no_content, "")
      end
    else 
      conn 
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:unprocessable_entity, Jason.encode!(%{"error" => "not authorized!"}) )
    end
  end
end
