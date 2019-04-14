defmodule Project2Web.NotificationController do
  use Project2Web, :controller

  alias Project2.Notifications
  alias Project2.Notifications.Notification
  alias Project2.Users

  action_fallback Project2Web.FallbackController

  plug Project2Web.Plugs.RequireAuth when action in [:index]

  def index(conn, %{"user_id" => user_id}) do
    current_user_id = Map.has_key?(conn.assigns, :current_user) && conn.assigns.current_user.id
    {user_id, _} = Integer.parse(user_id)
    
    # a user should only be able to see their own notifications
    if (current_user_id == user_id) do
      notifs = Notifications.list_notifications_for(user_id)
      |> Enum.map(fn notif -> 
          if notif.actor_id do
            actor = Users.get_user!(notif.actor_id)
            Map.put(notif, :actor_displayname, actor.display_name)   
          else
            Map.put(notif, :actor_displayname, nil)
          end
        end)   
      render(conn, "index.json", notifications: notifs)
    else 
      render(conn, "index.json", notifications: [])
    end 
  end
  def index(conn, _params) do
    notifications = Notifications.list_notifications()
    render(conn, "index.json", notifications: notifications)
  end

  def create(conn, %{"notification" => notification_params}) do
    with {:ok, %Notification{} = notification} <- Notifications.create_notification(notification_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.notification_path(conn, :show, notification))
      |> render("show.json", notification: notification)
    end
  end

  def show(conn, %{"id" => id}) do
    notification = Notifications.get_notification!(id)
    render(conn, "show.json", notification: notification)
  end

  def update(conn, %{"id" => id, "notification" => notification_params}) do
    notification = Notifications.get_notification!(id)

    with {:ok, %Notification{} = notification} <- Notifications.update_notification(notification, notification_params) do
      render(conn, "show.json", notification: notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    notification = Notifications.get_notification!(id)

    with {:ok, %Notification{}} <- Notifications.delete_notification(notification) do
      send_resp(conn, :no_content, "")
    end
  end
end
