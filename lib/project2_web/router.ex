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
    plug :fetch_session
  end

  scope "/", Project2Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/users", PageController, :index
    get "/users/:id", PageController, :index
    get "/posts/:id", PageController, :index
    get "/register", PageController, :index
    get "/edituser", PageController, :index
    get "/notifications", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", Project2Web do
    pipe_through :api

    #resources "/friendrequests", FriendRequestsController, except: [:new, :edit]
    resources "/pokes", PokeController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
    resources "/replies", ReplyController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    delete "/friends/:user_id", FriendController, :delete
    delete "/friendrequests/:user_id", FriendRequestController, :delete
    post "/friendrequests/:user_id", FriendRequestController, :create    
    put "/friendrequests/:user_id", FriendRequestController, :update    
    post "/pokes/:user_id", PokeController, :create
    post "/auth", AuthController, :authenticate
  end
end
