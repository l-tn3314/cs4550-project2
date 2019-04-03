defmodule Project2Web.PokeControllerTest do
  use Project2Web.ConnCase

  alias Project2.Pokes
  alias Project2.Pokes.Poke

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:poke) do
    {:ok, poke} = Pokes.create_poke(@create_attrs)
    poke
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pokes", %{conn: conn} do
      conn = get(conn, Routes.poke_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create poke" do
    test "renders poke when data is valid", %{conn: conn} do
      conn = post(conn, Routes.poke_path(conn, :create), poke: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.poke_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.poke_path(conn, :create), poke: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update poke" do
    setup [:create_poke]

    test "renders poke when data is valid", %{conn: conn, poke: %Poke{id: id} = poke} do
      conn = put(conn, Routes.poke_path(conn, :update, poke), poke: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.poke_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, poke: poke} do
      conn = put(conn, Routes.poke_path(conn, :update, poke), poke: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete poke" do
    setup [:create_poke]

    test "deletes chosen poke", %{conn: conn, poke: poke} do
      conn = delete(conn, Routes.poke_path(conn, :delete, poke))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.poke_path(conn, :show, poke))
      end
    end
  end

  defp create_poke(_) do
    poke = fixture(:poke)
    {:ok, poke: poke}
  end
end
