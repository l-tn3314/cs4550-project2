defmodule Project2Web.FriendRequestController do
  use Project2Web, :controller

  alias Project2.Friends
  alias Project2.Friends.FriendRequest

  action_fallback Project2Web.FallbackController

  def index(conn, _params) do
    friend_requests = Friends.list_friend_requests()
    render(conn, "index.json", friend_requests: friend_requests)
  end

  def create(conn, %{"friend_request" => friend_request_params}) do
    with {:ok, %FriendRequest{} = friend_request} <- Friends.create_friend_request(friend_request_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.friend_request_path(conn, :show, friend_request))
      |> render("show.json", friend_request: friend_request)
    end
  end

  def show(conn, %{"id" => id}) do
    friend_request = Friends.get_friend_request!(id)
    render(conn, "show.json", friend_request: friend_request)
  end

  def update(conn, %{"id" => id, "friend_request" => friend_request_params}) do
    friend_request = Friends.get_friend_request!(id)

    with {:ok, %FriendRequest{} = friend_request} <- Friends.update_friend_request(friend_request, friend_request_params) do
      render(conn, "show.json", friend_request: friend_request)
    end
  end

  def delete(conn, %{"id" => id}) do
    friend_request = Friends.get_friend_request!(id)

    with {:ok, %FriendRequest{}} <- Friends.delete_friend_request(friend_request) do
      send_resp(conn, :no_content, "")
    end
  end
end
