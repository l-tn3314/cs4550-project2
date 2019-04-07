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

  def create(conn, %{"poke" => poke_params}) do
      user = Project2.Users.get_user!(conn.assigns.current_user_id)

      arr = String.split(user.hometown, ",")

      city = Enum.at(arr, 0)
      country_code = String.trim(Enum.at(arr, 1))

      api_key = "e6d0c89e30239fe1489387d434108f24"
      url = "api.openweathermap.org/data/2.5/weather?q=#{city},#{country_code}&appid=#{api_key}"

      {:ok, response} = HTTPoison.get(url, [], [])
      json = Poison.decode!(response.body)

      weather = Enum.at(json["weather"], 0)["main"]
      accuracy = Enum.random(1..100)

      if (weather == "Clear") or 
          (weather == "Clouds" and accuracy > 20) or 
          (weather == "Rain" and accuracy > 50) or 
          (weather == "Snow" and accuracy > 80) do
          with {:ok, %Poke{} = poke} <- Pokes.create_poke(poke_params) do
            Project2Web.Endpoint.broadcast!("notifications:lobby", "poke", %{from: poke.sender, to: poke.recipient})
            create(conn, poke)
          end
      else
          conn
          |> put_flash(:info, "Poke Failed Due to Inclement Weather...")
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
