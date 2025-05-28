defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HelloWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelloWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # pipeline :auth do
  #   # plug :browser
  #   # plug :ensure_authenticated_user
  #   # plug :ensure_user_owns_review

  #   plug HelloWeb.Authentication
  # end

  scope "/", HelloWeb do
    pipe_through [:browser]

    get "/", PageController, :home
    get "/redirect-test", PageController, :redirect_test
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    # resources "/users", UserController
    # resources "/posts", PostController, only: [:index, :show]
    # resources "/comments", CommentController, except: [:delete]
    # resources "/users", UserController do
    #   resources "/posts", PostController
    # end
    # resources "/reviews", ReviewController
  end

  # scope("/") do
  #   pipe_through [:browser]

  #   get "/reviews", PostController, :index
  #   get "/reviews/:id", PostController, :show
  # end

  # scope("/") do
  #   pipe_through [:browser, :auth]

  #   get "/reviews/new", PostController, :new
  #   post "/reviews", PostController, :create
  # end

  # forward "/jobs", BackgroundJob.Plug

  # scope("/") do
  #   pipe_through [:authenticate_user, :ensure_admin]

  #   forward "/jobs", BackgroundJob.Plug, name: "Hello"
  # end

  # scope("/", AnotherAppWeb) do
  #   pipe_through :browser
  #   resources "/posts", PostController
  # end

  # scope("/admin", HelloWeb.Admin) do
  #   pipe_through :browser

  #   resources "/reviews", ReviewController
  #   resources "/images", ImageController
  #   resources "/users", UserController
  # end

  # scope("/api", Helloweb.Api, as: :api) do
  #   pipe_through :api

  #   scope("/v1", V1, as: :v1) do
  #     resources "/images", ImageController
  #     resources "/reviews", ReviewController
  #     resources "/users", UserController
  #   end
  # end

  # scope("/reviews", Helloweb) do
  #   pipe_through :auth
  #   resources "/", ReviewController
  # end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api

  #   resources "/reviews", ReviewController
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hello, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
