defmodule HelloWeb.HelloHTML do
  use HelloWeb, :html

  embed_templates "hello_html/*"

  attr :messenger, :string, default: nil

  def greet(assigns) do
    ~H"""
    <h2>Hello world, from {@messenger}</h2>
    """
  end
end
