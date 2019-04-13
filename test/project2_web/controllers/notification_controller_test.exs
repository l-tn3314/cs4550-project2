defmodule Project2Web.NotificationControllerTest do
  use Project2Web.ConnCase

  alias Project2.Notifications
  alias Project2.Notifications.Notification

  @create_attrs %{
    ent_id: 42,
    formatted_msg: "some formatted_msg",
    time: "2010-04-17T14:00:00Z",
    type: "some type"
  }
  @update_attrs %{
    ent_id: 43,
    formatted_msg: "some updated formatted_msg",
    time: "2011-05-18T15:01:01Z",
    type: "some updated type"
  }
  @invalid_attrs %{ent_id: nil, formatted_msg: nil, time: nil, type: nil}

  def fixture(:notification) do
    {:ok, notification} = Notifications.create_notification(@create_attrs)
    notification
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all notifications", %{conn: conn} do
      conn = get(conn, Routes.notification_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create notification" do
    test "renders notification when data is valid", %{conn: conn} do
      conn = post(conn, Routes.notification_path(conn, :create), notification: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "ent_id" => 42,
               "formatted_msg" => "some formatted_msg",
               "time" => "2010-04-17T14:00:00Z",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.notification_path(conn, :create), notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update notification" do
    setup [:create_notification]

    test "renders notification when data is valid", %{conn: conn, notification: %Notification{id: id} = notification} do
      conn = put(conn, Routes.notification_path(conn, :update, notification), notification: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "ent_id" => 43,
               "formatted_msg" => "some updated formatted_msg",
               "time" => "2011-05-18T15:01:01Z",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, notification: notification} do
      conn = put(conn, Routes.notification_path(conn, :update, notification), notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete notification" do
    setup [:create_notification]

    test "deletes chosen notification", %{conn: conn, notification: notification} do
      conn = delete(conn, Routes.notification_path(conn, :delete, notification))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.notification_path(conn, :show, notification))
      end
    end
  end

  defp create_notification(_) do
    notification = fixture(:notification)
    {:ok, notification: notification}
  end
end
