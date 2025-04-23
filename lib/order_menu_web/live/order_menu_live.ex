defmodule OrderMenuWeb.OrderMenuLive do
  use OrderMenuWeb, :live_view
  import OrderMenuWeb.MenuComponent
  import OrderMenuWeb.CartComponent

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <main>
    <.menu/>
    <.cart/>
    </main>
    """
  end
end
