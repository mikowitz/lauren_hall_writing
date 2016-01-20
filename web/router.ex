defmodule LaurenHallWriting.Router do
  use LaurenHallWriting.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LaurenHallWriting.Auth, repo: LaurenHallWriting.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LaurenHallWriting do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/work", PageController, :work
    get "/awards", PageController, :awards
    get "/contact", PageController, :contact

    resources "/sessions", SessionController, only: [:new, :create, :delete]


    get "/markdown", MarkdownController, :index
    get "/admin", SessionController, :new
  end

  scope "/admin", LaurenHallWriting do
    pipe_through [:browser, :authenticate_user]

    resources "/awards", AwardController
    resources "/bio", BioController
  end

  # Other scopes may use custom stacks.
  # scope "/api", LaurenHallWriting do
  #   pipe_through :api
  # end
end
