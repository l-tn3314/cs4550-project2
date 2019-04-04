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
  def create(conn, %{"user_id" => user_id}) do
    # TODO: replace with token verification?
    current_user_id = get_session(conn, :user_id)
    with {:ok, %FriendRequest{} = friend_request} <- Friends.create_friend_request(%{"sender_id": current_user_id, "receiver_id": user_id}) do
      conn
      |> put_status(:created)  
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
  def update(conn, %{"user_id" => user_id}) do
    # TODO: replace with token verification?
    current_user_id = get_session(conn, :user_id)
    
    friend_request = Friends.get_user_friend_request(user_id, current_user_id)
    if friend_request do   
      Friends.delete_friend_request(friend_request)
      Friends.create_friend(%{"lower_user_id": min(user_id, current_user_id), "higher_user_id": max(user_id, current_user_id)})
      render(conn, "show.json", friend_request: friend_request)
    else 
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
