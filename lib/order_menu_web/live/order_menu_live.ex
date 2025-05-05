defmodule OrderMenuWeb.OrderMenuLive do
  use OrderMenuWeb, :live_view

    @spec mount(any(), any(), map()) :: {:ok, map()}

    def mount(_params, _session, socket) do
      menu_items =
        "priv/static/data.json"
        |> File.read!()
        |> Jason.decode!()
        |> Enum.map(fn item -> Map.put(item, "count", 0) end)
        # IO.puts("DearJSON: #{inspect(menu_items)}")
      {:ok, assign(socket, menu_items: menu_items, is_clicked: false, count_order: 0, confirm_btn: false, total_price: 0)}
    end

    @spec handle_event(<<_::136>>, any(), any()) :: {:noreply, any()}

    def handle_event("handle_is_clicked", _unsigned_params, socket) do
      update_is_clicked = !socket.assigns.is_clicked
      {:noreply, assign(socket, is_clicked: update_is_clicked)}
    end

    def handle_event("increment", %{"index" => index_str}, socket) do
      index = String.to_integer(index_str)

      updated_items = List.update_at(socket.assigns.menu_items, index, fn item ->
        Map.update!(item, "count", &(&1 + 1))
      end)

      {:noreply, assign(socket, :menu_items, updated_items)}
      # {:noreply, update(socket, :count_order, &(&1 + 1))}
    end

    def handle_event("decrement", %{"index" => index_str}, socket) do
      index = String.to_integer(index_str)

      update_items = List.update_at(socket.assigns.menu_items, index, fn item ->
        Map.update!(item, "count",  &max(&1 - 1, 0))
      end)

      {:noreply, assign(socket, :menu_items, update_items)}
    end

    def handle_event("confirm_order", _params, socket) do
      {:noreply, assign(socket, confirm_btn: !socket.assigns.confirm_btn)}
    end


    def render(assigns) do
      ~H"""
      <% orders = Enum.filter(@menu_items, fn item -> item["count"] > 0 end) %>
      <%!-- <%= inspect(Enum.filter(@menu_items, fn item -> item["count"] > 0 end)) %> --%>
      <% total_price = Enum.reduce(orders, 0, fn item, acc -> acc + item["count"] * item["price"] end) %>
        <main class="bg-[#FBF8F6] flex gap-8 py-[86px] px-[114px]">
        <%!-- MENU LIST ⬇️ --%>
        <section  class="">
        <h1 class="font-bold mb-10 text-5xl">Desserts</h1>
        <ul class="grid grid-cols-3 gap-x-4 w-[980px]">
        <%= for {item, index} <- Enum.with_index(@menu_items) do %>
        <li class="flex flex-col">
        <img class="w-[300px] h-[300px] rounded-md" src={"#{item["image"]["desktop"]}"} alt={item["name"]} />
        <%= if @is_clicked do%>
        <div class=" bg-[#c73a0f] px-6 text-white flex justify-between items-center border border-2 rounded-full max-w-[150px] py-1" phx-click="handle_is_clicked">
        <button class="border w-5 h-5 flex justify-center items-center rounded-full" phx-click="decrement"  phx-value-index={index}>-</button>
        <%= item["count"] %>
        <button class="border w-5 h-5 flex justify-center items-center rounded-full" phx-click="increment"  phx-value-index={index}>+</button>
        </div>
        <%else%>
        <button class="bottom-0 bg-white border border-2 rounded-full max-w-[150px] py-1"  phx-click="handle_is_clicked">Add to Cart</button>
        <% end %>
        <span class="text-[#9C9591]"><%= item["category"]%></span>
        <p class="font-bold"><%= item["name"]%></p>
        <span class="text-[#c73a0f] font-bold">$<%= item["price"] %></span>
        </li>
        <% end %>
        </ul>
        </section>
        <%!-- CART ⬇️ --%>
        <section class="bg-white rounded-lg p-6 max-w-[600px] h-fit w-full">
       <div>
          <h1 class="text-[#c73a0f] font-bold text-3xl mb-6">Your Cart <span>(<%= length(orders)%>)</span></h1>
          <%= if length(orders) > 0 do %>
          <ul >
         <%= for order <- orders do%>
          <li class="border-b py-4">
            <h1 class="font-bold"><%= order["name"] %></h1>
            <div class="flex">
            <p class="text-[#c73a0f]"><%= order["count"] %>X</p>
             <span>@ $<%= order["price"]%></span>
            <span>$<%= order["count"] * order["price"] %></span>
            </div>
           </li>
         <% end %>
          </ul>
          <%end%>
          <div class="my-10 flex justify-between">
          <span class="text-slate-600">Order Total</span>
          <span class="font-bold text-2xl">$<%= total_price %></span>
          </div>
        </div>
        <div class="bg-[#FBF8F6] rounded-lg h-[50px] mb-6 flex items-center justify-center"><p>This is a <b> carbon-neutral</b> delivery</p></div>
           <button class="bg-[#c73a0f] text-white w-full h-[50px] rounded-full hover:bg-[#8A341A]" phx-click="confirm_order">Confirm Order</button>
        </section>
        <%!-- ORDER CONFIRMED ⬇️ --%>
        <%= if @confirm_btn do %>
        <section class="absolute overflow-hidden top-0 left-0 bg-[hsla(13,1%,14%,0.5)] flex items-center justify-center w-screen h-screen">
        <div class="bg-white p-10 rounded-xl">
        <h1 class="text-5xl font-bold">Order Confirmed</h1>
        <p class="text-[hsl(14, 24.50%, 72.00%)]">We hope you enjoy your food!</p>
        <ul class="my-10">
        <%= for order <- orders do%>
        <img class="w-14 h-14 rounded-md" src={"#{order["image"]["desktop"]}"} alt={order["name"]}/>
        <div class="flex">
          <p><%= order["name"]%></p>
          <div>
           <span><%= order["count"]%>X</span>
           <span>@ $<%= order["price"]%></span>
           </div>
        </div>
        <span>$<%= order["count"] * order["price"] %></span>
        <% end %>
        </ul>

        <div>
          <span>Order Total</span>
          <span>$<%= total_price %></span>
        </div>
        <button phx-click="confirm_order">Start New Order</button>
        </div>
        </section>
        <%end%>
      </main>
      """
    end
  end
