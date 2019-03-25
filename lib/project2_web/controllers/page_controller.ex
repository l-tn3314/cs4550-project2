defmodule Project2Web.PageController do
  use Project2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
