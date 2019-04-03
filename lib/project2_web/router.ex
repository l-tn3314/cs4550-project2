defmodule Project2Web.Router do
  use Project2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Project2Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/users", PageController, :index
    get "/posts", PageController, :index
    get "/replies", PageController, :index
    get "/pokes", PageController, :index
  end

  # Other scopes may use custom stacks.
   scope "/api/v1", Project2Web do
     pipe_through :api

     resources "/users", UserController, except: [:new, :edit]
     resources "/posts", PostController, except: [:new, :edit]
     resources "/replies", ReplyController, except: [:new, :edit]
     resources "/pokes", PokeController, except: [:new, :edit]
     post "/auth", AuthController, :authenticate
   end
end
