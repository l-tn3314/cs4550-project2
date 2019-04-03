defmodule Project2Web.PokeController do
  use Project2Web, :controller

  alias Project2.Pokes
  alias Project2.Pokes.Poke

  action_fallback Project2Web.FallbackController

  def index(conn, _params) do
    pokes = Pokes.list_pokes()
    render(conn, "index.json", pokes: pokes)
  end

  def create(conn, %{"poke" => poke_params}) do
    with {:ok, %Poke{} = poke} <- Pokes.create_poke(poke_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.poke_path(conn, :show, poke))
      |> render("show.json", poke: poke)
    end
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
