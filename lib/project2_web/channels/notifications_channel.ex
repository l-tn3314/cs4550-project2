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

  def handle_in("subscribe", %{"token" => user_token}, socket) do
    case Phoenix.Token.verify(socket, "user_id", user_token, max_age: 1209600) do
      {:ok, user_id} ->
        {:noreply, assign(socket, :current_user_id, user_id)}
      {:error, _} ->
        {:noreply, %{reason: "unauthorized"}}
    end
  end

  def handle_in("unsubscribe", _payload, socket) do
    {:noreply, assign(socket, :current_user_id, nil)}
  end
  
  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  intercept ["poke", "friend_request", "friend_accept"]

  def handle_out(ev, payload, socket) when ev in ["poke", "friend_request", "friend_accept"] do
    current_id = Map.has_key?(socket.assigns, :current_user_id) && socket.assigns.current_user_id
    if (current_id == payload.to) do
      # send a notification to the state
      push(socket, ev, payload)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

end
