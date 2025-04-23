defmodule OrderMenuWeb.CartComponent do
  use Phoenix.Component

  def cart(assigns) do
    ~H"""
    <section>
       <h1>Your Cart</h1>
    </section>
    """
  end

end
