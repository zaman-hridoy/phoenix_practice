defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  plug :put_view, html: HelloWeb.PageHTML, json: HelloWeb.PageJSON

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # render(conn, :home, layout: false)
    # conn |> put_resp_content_type("text/plain") |> send_resp(201, "")
    # conn |> put_status(202) |> render(:home, layout: false)
    # redirect(conn, to: ~p"/redirect-test")
    # redirect(conn, external: "https://elixir-lang.org/")
    conn
    |> put_flash(:error, "Let's pretend we have an error!")
    |> redirect(to: ~p"/redirect-test")
  end

  def redirect_test(conn, _params) do
    render(conn, :home, layout: false)
  end
end
