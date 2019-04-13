defmodule Project2Web.NotificationView do
  use Project2Web, :view
  alias Project2Web.NotificationView

  def render("index.json", %{notifications: notifications}) do
    %{data: render_many(notifications, NotificationView, "notification.json")}
  end

  def render("show.json", %{notification: notification}) do
    %{data: render_one(notification, NotificationView, "notification.json")}
  end

  def render("notification.json", %{notification: notification}) do
    %{id: notification.id,
      ent_id: notification.ent_id,
      type: notification.type,
      formatted_msg: notification.formatted_msg,
      time: notification.time}
  end
end
