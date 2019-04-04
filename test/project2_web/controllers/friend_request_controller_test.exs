defmodule Project2Web.FriendRequestControllerTest do
  use Project2Web.ConnCase

  alias Project2.Friends
  alias Project2.Friends.FriendRequest

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:friend_request) do
    {:ok, friend_request} = Friends.create_friend_request(@create_attrs)
    friend_request
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all friend_requests", %{conn: conn} do
      conn = get(conn, Routes.friend_request_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create friend_request" do
    test "renders friend_request when data is valid", %{conn: conn} do
      conn = post(conn, Routes.friend_request_path(conn, :create), friend_request: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.friend_request_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.friend_request_path(conn, :create), friend_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update friend_request" do
    setup [:create_friend_request]

    test "renders friend_request when data is valid", %{conn: conn, friend_request: %FriendRequest{id: id} = friend_request} do
      conn = put(conn, Routes.friend_request_path(conn, :update, friend_request), friend_request: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.friend_request_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, friend_request: friend_request} do
      conn = put(conn, Routes.friend_request_path(conn, :update, friend_request), friend_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete friend_request" do
    setup [:create_friend_request]

    test "deletes chosen friend_request", %{conn: conn, friend_request: friend_request} do
      conn = delete(conn, Routes.friend_request_path(conn, :delete, friend_request))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.friend_request_path(conn, :show, friend_request))
      end
    end
  end

  defp create_friend_request(_) do
    friend_request = fixture(:friend_request)
    {:ok, friend_request: friend_request}
  end
end
