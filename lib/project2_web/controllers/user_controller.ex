defmodule Project2Web.UserController do
  use Project2Web, :controller

  alias Project2.Users
  alias Project2.Users.User
  alias Project2.Friends

  action_fallback Project2Web.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "points", 0)
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user(id)
    arr = String.split(user.hometown, ",")

    city = Enum.at(arr, 0)
    country_code = String.trim(Enum.at(arr, 1))

    api_key = "e6d0c89e30239fe1489387d434108f24"
    url = "api.openweathermap.org/data/2.5/weather?q=#{city},#{country_code}&appid=#{api_key}"

    {:ok, response} = HTTPoison.get(url, [], [])
    json = Poison.decode!(response.body)

    weather = Enum.at(json["weather"], 0)["main"]
    friends = Friends.get_friend_ids_for(id)
    {req_sent_to, req_recv_from} = Friends.get_friend_requests_for(id)

    [token | _] = get_req_header(conn, "x-auth")
    case Phoenix.Token.verify(Project2Web.Endpoint, "user_id", token, max_age: 86400) do
      {:ok, user_id} ->
        friend_info = Map.put(%{}, :is_friend, Enum.member?(friends, user_id))
        |> Map.put(:has_request_from, Enum.member?(req_sent_to, user_id))
        |> Map.put(:sent_request_to, Enum.member?(req_recv_from, user_id))
        render(conn, "show.json", user: user, friend_info: friend_info, weather_info: weather)
      {:error, _ } -> 
        # user not logged in
        friend_info = Map.put(%{}, :is_friend, nil)
        |> Map.put(:has_request_from, nil)
        |> Map.put(:sent_request_to, nil)
        render(conn, "show.json", user: user, friend_info: friend_info, weather_info: weather)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
