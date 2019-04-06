defmodule Project2Web.NotificationsChannel do
  use Project2Web, :channel

  def join("notifications:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (notifications:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  intercept ["poke", "friend_request"]

  def handle_out("poke", payload, socket) do
    current_id = socket.assigns.current_user.id
    if (current_id === payload.to) do
      # send a notification to the state
      {:noreply, socket}
    else
      push socket, "poke", payload 
    end
  end

  def handle_out("friend_request", payload, socket) do
    current_id = socket.assigns.current_user.id
    if (current_id === payload.to) do
      # send a notification to the state
      {:noreply, socket}
    else
      push socket, "friend_request", payload
    end
  end
end
