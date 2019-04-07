defmodule Project2Web.PokeController do
  use Project2Web, :controller

  alias Project2.Pokes
  alias Project2.Pokes.Poke

  action_fallback Project2Web.FallbackController

  plug Project2Web.Plugs.RequireAuth when action in [:create, :update, :delete]
  
  def index(conn, _params) do
    pokes = Pokes.list_pokes()
    render(conn, "index.json", pokes: pokes)
  end

#  def create(conn, %{"poke" => poke_params}) do
  def create(conn, %{"user_id" => user_id}) do
      current_user_id = conn.assigns.current_user.id
      user = Project2.Users.get_user!(conn.assigns.current_user.id)

      arr = String.split(user.hometown, ",")

      city = Enum.at(arr, 0)
      country_code = String.trim(Enum.at(arr, 1))

      api_key = "e6d0c89e30239fe1489387d434108f24"
      url = "api.openweathermap.org/data/2.5/weather?q=#{city},#{country_code}&appid=#{api_key}"

      {:ok, response} = HTTPoison.get(url, [], [])
      json = Poison.decode!(response.body)

# slight bug when performing api call on a city that contains a space
      weather = Enum.at(json["weather"], 0)["main"]
      accuracy = Enum.random(1..100)

      if (weather == "Clear") or 
          (weather == "Clouds" and accuracy > 20) or 
          (weather == "Rain" and accuracy > 50) or 
          (weather == "Snow" and accuracy > 80) do
          with {:ok, %Poke{} = poke} <- Pokes.create_poke(%{"sender": current_user_id, "recipient": user_id}) do
            Project2Web.Endpoint.broadcast!("notifications:lobby", "poke", %{from: poke.sender, to: poke.recipient, "sender_displayname": user.display_name})
            new_points = user.points + 100
            Project2.Users.update_user(user, %{points: new_points})
            create(conn, poke)
          end
      else
          new_points = user.points - 100
          Project2.Users.update_user(user, %{points: new_points})
          conn
          |> put_resp_header("content-type", "application/json; charset=UTF-8")
          |> send_resp(:unprocessable_entity, Jason.encode!(%{error: "Poke failed due to inclement weather..."}))
      end
    end

  def create(conn, poke) do
    conn
    |> put_status(:created)
    |> put_resp_header("location", Routes.poke_path(conn, :show, poke))
    |> render("show.json", poke: poke)
    end

  def show(conn, %{"id" => id}) do
    poke = Pokes.get_poke!(id)
    render(conn, "show.json", poke: poke)
  end

  def update(conn, %{"id" => id, "poke" => poke_params}) do
    poke = Pokes.get_poke!(id)

    with {:ok, %Poke{} = poke} <- Pokes.update_poke(poke, poke_params) do
      render(conn, "show.json", poke: poke)
    end
  end

  def delete(conn, %{"id" => id}) do
    poke = Pokes.get_poke!(id)

    with {:ok, %Poke{}} <- Pokes.delete_poke(poke) do
      send_resp(conn, :no_content, "")
    end
  end
end
