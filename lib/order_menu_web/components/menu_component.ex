# defmodule OrderMenuWeb.MenuComponent do
#   # use OrderMenuWeb, :live_component
#    use OrderMenuWeb, :live_view


# @impl true
# @spec mount(any(), any(), any()) :: {:ok, any()}
# def mount(_params, _session, socket) do
#   isOpened = nil
#   {:ok, assign(socket, isOpened: isOpened)}
# end

#   # def test_items, do: IO.puts("Items: #{@items}")

#   @impl true
#   @spec render(any()) :: Phoenix.LiveView.Rendered.t()
#   def render(assigns) do
#     ~H"""
#     <section>
#       <h1>Desserts</h1>
#       <ul class="grid grid-cols-3">
#       <%= for item <- @items do %>
#         <div>
#           <h1><%= item["name"] %></h1>
#           <img class="w-[200px] h-[200px]" src={"#{item["image"]["desktop"]}"} alt={item["name"]} />
#           <div>
#           <button class="border border-rose-800 rounded-full px-8 py-1" >Add to Cart</button>
#           <%!-- <div class="border border-rose-800 rounded-full px-8 py-1 max-w-[100px] flex justify-between"> --%>
#           <button>-</button>0<button>+</button>
#           </div>
#         </div>
#       <% end %>
#       </ul>

#     </section>
#     """
#   end
# end



# # defmodule OrderMenuWeb.MenuComponent do
# #   # use Phoenix.Component
# #   use OrderMenuWeb, :live_component

# #   # @spec mount(any(), any(), any()) :: {:ok, any()}
# #   # def mount(_params, _session, socket) do
# #   #   IO.puts("mounted")
# #   #   menu_data = read_json()
# #   #   IO.puts("json mount output: #{inspect(menu_data)}")
# #   #   {:ok, assign(socket, data: menu_data)}
# #   # end



# #   # @spec read_json() :: any()
# #   # def read_json do
# #   #   file = File.read!("priv/static/data.json")
# #   #   |> Jason.decode!()
# #   #   IO.puts("json output: #{inspect(file)}")
# #   #   file
# #   # end

# #   # attr :menu_items, :list, required: true

# #   # @spec menu(map()) :: Phoenix.LiveView.Rendered.t()

# #   @impl true
# #   def menu(assigns) do
# #     ~H"""
# #         <section>
# #          <h1>Dessets</h1>
# #          <ul>
# #          <%= for item <- @menu_items do %>
# #             <div>
# #             <h1><%= item["name"] %></h1>
# #             <%!-- <img src={"#{item["image"]["desktop"]}"} alt={item["name"]} /> --%>
# #             </div>
# #           <% end %>
# #          </ul>
# #          <button>Add to Cart</button>
# #          <button> - </button>
# #       </section>
# #     """
# #   end
# # end
