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
        <main class="bg-[#FBF8F6] grid grid-cols-2 gap-8 py-[72px] px-[92px]">
        <%!-- MENU LIST ⬇️ --%>
        <section  class="">
        <h1 class="font-bold mb-10">Desserts</h1>
        <ul class="grid grid-cols-3 gap-x-4">
        <%= for item <- @menu_items do %>
        <li>
        <img class="w-[200px] h-[200px] rounded-md" src={"#{item["image"]["desktop"]}"} alt={item["name"]} />
        <span class="text-[#9C9591]"><%= item["category"]%></span>
        <p class="font-bold"><%= item["name"]%></p>
        <span class="text-[#c73a0f] font-bold">$<%= item["price"] %></span>
        </li>
        <% end %>
        </ul>
        </section>
        <%!-- CART ⬇️ --%>
        <section  class="bg-white rounded-lg max-w-[600px]">
       <div>
          <h1 class="text-[#c73a0f] font-bold">Your Cart <span>(7)</span></h1>
          <ul></ul>
          <div><span>Order Total</span><span class="font-bold">$46.50</span></div>
        </div>
      <button class="bg-[#c73a0f] text-white">Confirm Order</button>

        </section>
        <%!-- ORDER CONFIRMED ⬇️ --%>
        <section  class="bg-white">OrderConfirmed</section>
      </main>
      """
    end
  end
