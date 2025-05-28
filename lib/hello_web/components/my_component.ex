defmodule HelloWeb.MyComponent do
  use Phoenix.Component, global_prefixes: ~w(x-)

  embed_templates "cards/*"

  attr :name, :string, default: "Bob"

  def greet(assigns) do
    ~H"""
    <p>Hello, <b>{@name}</b></p>
    """
  end

  attr :name, :string, default: nil
  attr :age, :integer, required: true

  def celebrate(assigns) do
    ~H"""
    <p>
      Happy Birthday <b>{@name}</b>!
      You are {@age} years old.
    </p>
    """
  end

  attr :message, :string, required: true
  attr :rest, :global, default: %{class: "text-orange-600"}

  def notification(assigns) do
    ~H"""
    <span {@rest}>{@message}</span>
    """
  end

  attr :rest, :global, include: ~w(form)
  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <button {@rest}>
      {render_slot(@inner_block)}
    </button>
    """
  end

  slot :inner_block, required: true
  attr :entries, :list, default: []

  def unordered_list(assigns) do
    ~H"""
    <ul>
      <li :for={entry <- @entries}>
        {render_slot(@inner_block, entry)}
      </li>
    </ul>
    """
  end

  slot :header
  slot :inner_block, required: true
  slot :footer, required: true

  def modal(assigns) do
    ~H"""
    <div class="modal fixed inset-0 bg-black/65" hidden>
      <div class="w-1/2 h-auto min-h-[500] drop-shadow-md fixed bg-white rounded-sm top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 p-6">
        <div class="modal-header">
          {render_slot(@header) || "Modal"}
        </div>
        <div class="modal-body">
          {render_slot(@inner_block)}
        </div>
        <div class="modal-footer">
          {render_slot(@footer)}
        </div>
      </div>
    </div>
    """
  end

  attr :rows, :list, default: []

  slot :column, doc: "Columns with label" do
    attr :label, :string, required: true, doc: "Column label"
  end

  def table(assigns) do
    ~H"""
    <table>
      <tr>
        <th :for={col <- @column}>{col.label}</th>
      </tr>
      <tr :for={row <- @rows}>
        <td :for={col <- @column}>
          {render_slot(col, row)}
        </td>
      </tr>
    </table>
    """
  end

  def landing_hero(assigns) do
    ~H"""
    <.pricing_card />
    <.features_card />
    """
  end
end
