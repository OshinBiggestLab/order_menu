defmodule OrderMenuWeb.OrderMenuLive do
  use OrderMenuWeb, :live_view

    # def mount(_params, _session, socket) do
    #   IO.puts("mounted")
    #   menu_data = read_json()
    #   IO.puts("json mount output: #{inspect(menu_data)}")
    #   {:ok, assign(socket, data: menu_data)}
    # end

    # def read_json do
    #   file = File.read!("priv/static/data.json")
    #   |> Jason.decode!()
    #   IO.puts("json output: #{inspect(file)}")
    #   file
    # end

    @spec mount(any(), any(), map()) :: {:ok, map()}
    def mount(_params, _session, socket) do
      menu_items =
        "priv/static/data.json"
        |> File.read!()
        |> Jason.decode!()
        # IO.puts("DearJSON: #{inspect(menu_items)}")
      {:ok, assign(socket, :menu_items, menu_items)}
    end



    def render(assigns) do
      ~H"""
        <main>
        <%= live_render(@socket, OrderMenuWeb.MenuComponent, id: "menu_component", items: @menu_items) %>
        <%!-- <.live_component module={OrderMenuWeb.CartComponent} id="cart_component" /> --%>
      </main>
      """
    end
  end
