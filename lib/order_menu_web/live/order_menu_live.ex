defmodule OrderMenuWeb.OrderMenuLive do
  use OrderMenuWeb, :live_view

    @spec mount(any(), any(), map()) :: {:ok, map()}

    def mount(_params, _session, socket) do
      menu_items =
        "priv/static/data.json"
        |> File.read!()
        |> Jason.decode!()
        |> Enum.map(fn item ->
          item
          |> Map.put( "count", 0)
          |> Map.put("is_clicked", false)
        end)
        # IO.puts("DearJSON: #{inspect(menu_items)}")
      {:ok, assign(socket, menu_items: menu_items, count_order: 0, confirm_btn: false, total_price: 0)}
    end

    @spec handle_event(<<_::136>>, any(), any()) :: {:noreply, any()}

    def handle_event("handle_is_clicked",  %{"name" => name}, socket) do
      updated_menu_items = Enum.map(socket.assigns.menu_items, fn item ->
        if item["name"] == name do
          Map.put(item, "is_clicked", true)
        else
          item
        end
      end)

      {:noreply, assign(socket, menu_items: updated_menu_items)}
    end

    def handle_event("increment", %{"index" => index_str}, socket) do
      index = String.to_integer(index_str)

      updated_items = List.update_at(socket.assigns.menu_items, index, fn item ->
        Map.update!(item, "count", &(&1 + 1))
      end)

      total_price = Enum.reduce(updated_items, 0, fn item, acc -> acc + item["count"] * item["price"] end)

      {:noreply, assign(socket, menu_items: updated_items, total_price: total_price)}
      # {:noreply, update(socket, :count_order, &(&1 + 1))}
    end



    def handle_event("decrement", %{"index" => index_str}, socket) do
      index = String.to_integer(index_str)

      updated_items = List.update_at(socket.assigns.menu_items, index, fn item ->
          if  item["is_clicked"] && item["count"] == 1 do
            item
              |>  Map.update!("count",  &max(&1 - 1, 0))
              |>  Map.put("is_clicked", false)
          else
            Map.update!(item, "count",  &max(&1 - 1, 0))
          end
      end)

      total_price = Enum.reduce(updated_items, 0, fn item, acc -> acc + item["count"] * item["price"] end)

      {:noreply, assign(socket, menu_items: updated_items, total_price: total_price)}
    end

    def handle_event("confirm_order", _params, socket) do
      {:noreply, assign(socket, confirm_btn: !socket.assigns.confirm_btn)}
    end

    def handle_event("cancel_item", %{"name" => name}, socket) do
      updated_items =
        Enum.map(socket.assigns.menu_items, fn item ->
          if item["name"] == name do
            Map.put(item, "count", 0)
          else
            item
          end
        end)

      total_price =
        Enum.reduce(updated_items, 0, fn item, acc ->
          acc + item["count"] * item["price"]
        end)

      {:noreply, assign(socket, menu_items: updated_items, total_price: total_price)}
    end

    def render(assigns) do
      ~H"""
      <% orders = Enum.filter(@menu_items, fn item -> item["count"] > 0 end) %>

        <main class={"w-full font-redhat bg-[#FBF8F6] flex gap-8 py-[86px] px-10 items-center justify-center mobile:flex-col laptop:flex-row" <> if @confirm_btn, do: " fixed", else: "" } >
         <%!-- MENU LIST ⬇️ --%>
         <section  class="">
        <h1 class="font-bold mb-10 text-5xl">Desserts</h1>
        <ul class="grid screen1024:gap-x-4 screen1024:grid-cols-2 laptop:grid-cols-3 laptop:min-w-[980px]">
        <%= for {item, index} <- Enum.with_index(@menu_items) do %>
        <li class="flex flex-col justify-center items-center w-fit">
        <img class={"relative max-w-[300px] max-h-[300px] rounded-xl" <> if item["count"] > 0, do: " border-[4px] border-red-600", else: ""} src={"#{item["image"]["desktop"]}"} alt={item["name"]} />
        <%= if item["is_clicked"] do%>
        <div class="absolute mt-[120px] bg-[#c73a0f] px-6 text-white flex justify-between items-center rounded-full w-full max-w-[160px] h-11" >
        <button class="border w-5 h-5 flex justify-center items-center rounded-full" phx-click="decrement"  phx-value-index={index}>-</button>
        <%= item["count"] %>
        <button class="border w-5 h-5 flex justify-center items-center rounded-full" phx-click="increment"  phx-value-index={index}>+</button>
        </div>
        <%else%>
        <button class="absolute mt-[120px] font-semibold bg-white border border-[#9F9392] border-1 rounded-full w-full max-w-[160px] h-11 hover:text-[#c73a0f] hover:border-[#c73a0f] hover:bg-[hsl(20, 50%, 98%)]"  phx-click="handle_is_clicked" phx-value-name={item["name"]}>Add to Cart</button>
        <% end %>
        <div class="my-10 flex flex-col gap-y-1 w-full">
        <span class="text-[#9C9591] text-md"><%= item["category"]%></span>
        <p class="text-xl"><%= item["name"]%></p>
        <span class="text-[#c73a0f] text-xl">$<%= :erlang.float_to_binary(Float.parse(item["price"] |> to_string) |> elem(0), decimals: 2) %>
        </span>
        </div>
        </li>
        <% end %>
        </ul>
        </section>
        <%!-- CART ⬇️ --%>
        <section class="bg-white rounded-2xl p-8 max-w-[600px] h-fit w-full laptop:self-start">
       <div>
          <h1 class="text-[#c73a0f] font-bold text-3xl mb-6">Your Cart <span>(<%= length(orders)%>)</span></h1>
          <%= if length(orders) > 0 do %>
          <ul >
         <%= for order <- orders do%>
          <li class="border-b border-[#F5F3F0] py-4 flex justify-between">
          <div>
            <h1 class="font-bold mb-2"><%= order["name"] %></h1>
            <div class="flex">
            <p class="text-[#c73a0f] font-bold"><%= order["count"] %>x</p>
             <span class="text-[#ABA19D] ml-5 mr-2"><span class="text-sm">@</span> $<%= :erlang.float_to_binary(Float.parse(order["price"] |> to_string) |> elem(0), decimals: 2) %>
             </span>
            <span class="text-[#8C7E7E]">
            $<%=
                  count = Float.parse(order["count"] |> to_string) |> elem(0)
                  price = Float.parse(order["price"] |> to_string) |> elem(0)
                  :erlang.float_to_binary(count * price, decimals: 2)
              %>
              </span>
            </div>
            </div>
            <button class="font-semibold" phx-click="cancel_item" phx-value-name={order["name"]}>Cancel</button>
           </li>
         <% end %>
          </ul>
          <div class="my-10 flex justify-between">
            <span class="text-slate-600">Order Total</span>
            <span class="font-bold text-2xl">$<%= :erlang.float_to_binary(Float.parse(@total_price |> to_string) |> elem(0), decimals: 2) %>
            </span>
            </div>
            <div class="bg-[#FBF8F6] fef7f4 rounded-lg h-[50px] mb-6 flex items-center justify-center"><p>This is a <b> carbon-neutral</b> delivery</p></div>
            <button class="bg-[#c73a0f] text-white w-full h-[50px] rounded-full hover:bg-[#8A341A]" phx-click="confirm_order">Confirm Order</button>
            <% else %>
            <p class="text-center text-[#765b52] text-lg font-semibold mb-4 mt-10">Your added items will appear here</p>
          <%end%>
        </div>
        </section>
        <%!-- ORDER CONFIRMED ⬇️ --%>
        <%= if @confirm_btn do %>
        <section class="fixed overflow-hidden inset-0 bg-[hsla(0,0%,10%,0.6)] flex items-center justify-center w-screen h-screen">
        <div class="bg-white max-w-[592px] w-full p-10 rounded-xl">
        <h1 class="text-5xl font-bold mb-4">Order Confirmed</h1>
        <p class="text-[#6e5c56] text-lg">We hope you enjoy your food!</p>
        <div>
        <ul class="my-10 px-6 pb-6 pt-3 rounded-md bg-[#FBF8F6] ">
        <%= for order <- orders do%>
        <li class="flex items-center justify-between border-b border-[hsl(13, 31%, 94%)] pt-4 pb-8">
        <div class="flex gap-x-4">
        <img class="w-14 h-14 rounded-md" src={"#{order["image"]["desktop"]}"} alt={order["name"]}/>
        <div class="flex flex-col">
          <p class="font-bold mb-2"><%= order["name"]%></p>
          <div>
           <span class="text-[#c73a0f]"><%= order["count"]%>x</span>
           <span class="text-[#ABA19D] ml-4"><span class="text-sm">@</span> $<%= :erlang.float_to_binary(Float.parse(order["price"] |> to_string) |> elem(0), decimals: 2) %></span>
           </div>
        </div>
        </div>
        <span class="font-semibold">$
        <%=
           count = Float.parse(order["count"] |> to_string) |> elem(0)
           price = Float.parse(order["price"] |> to_string) |> elem(0)
           :erlang.float_to_binary(count * price, decimals: 2)
        %>
        </span>
        </li>
        <% end %>
        <div class="mt-8 flex justify-between">
          <span>Order Total</span>
          <span class="font-bold text-2xl">$<%= :erlang.float_to_binary(Float.parse(@total_price |> to_string) |> elem(0), decimals: 2) %></span>
        </div>
        </ul>
          </div>
        <button class="w-full h-[54px] text-white rounded-full bg-[#c73a0f] hover:bg-[#8A341A]" phx-click="confirm_order">Start New Order</button>
        </div>
        </section>
        <%end%>
      </main>
      """
    end
  end
