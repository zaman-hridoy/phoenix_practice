defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"messenger" => messenger} = _params) do
    # render(conn, :show, messenger: messenger)
    # text(conn, "From messenger #{messenger}")
    # json(conn, %{id: 45544, name: messenger})

    # conn
    # |> Plug.Conn.assign(:messenger, messenger)
    # |> assign(:receiver, "John")
    # |> render(:show)
    conn
    |> put_layout(html: :admin)
    |> render(:show,
      messenger: messenger,
      receiver: "Jane miller",
      has_receiver: true,
      class: "text-red-500"
    )
  end
end
