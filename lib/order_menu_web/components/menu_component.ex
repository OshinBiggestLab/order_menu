defmodule OrderMenuWeb.MenuComponent do
  use Phoenix.Component


  def read_json do
    file = File.read!("priv/static/data.json")
    |> Jason.decode!()
    #IO.puts("json output: #{inspect(file)}")
    file
  end

  @spec menu(any()) :: Phoenix.LiveView.Rendered.t()
  def menu(assigns) do
    ~H"""
      <section>
         <h1>Dessets</h1>
      </section>
    """
  end
end
