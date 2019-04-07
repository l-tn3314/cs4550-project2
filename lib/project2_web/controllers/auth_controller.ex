defmodule Project2Web.AuthController do
  use Project2Web, :controller

    alias Project2.Users
    alias Project2.Users.User

    action_fallback Project2Web.FallbackController

    def authenticate(conn, %{"email" => email, "password" => password}) do
      with {:ok, %User{} = user} <- Users.authenticate_user(email, password) do
        resp = %{
          data: %{
            token: Phoenix.Token.sign(Project2Web.Endpoint, "user_id", user.id),
            user_id: user.id,
            display_name: user.display_name,
           }
         }

      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:created, Jason.encode!(resp))
      end
    end
end

